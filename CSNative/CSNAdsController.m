#import "CSNAdsController.h"
#import "CSNClient.h"
#import "CSNHttpClient.h"
#import "CSNMockClient.h"
#import "CSNLogoView.h"
#import "CSNModalWindow.h"
#import "CSNVisibilityMonitor.h"
#import "Csnmessages.pbobjc.h"

@interface CSNAdsController ()
@property id<CSNClient> client;
@property CSNVisibilityMonitor *visMonitor;
@property NSMutableDictionary *cachedResponses;
@end

@implementation CSNAdsController

CSNModalWindow *modalWindowView;

- (instancetype) init {
    return [self initWithClient:[[CSNHttpClient alloc] initWithHost:@"api.commutestream.com"]];
}

- (instancetype) initMocked {
    return [self initWithClient:[[CSNMockClient alloc] init]];
}

- (instancetype) initWithClient:(id<CSNClient>)client {
    _client = client;
    _cachedResponses = [[NSMutableDictionary alloc] init];
    _visMonitor = [[CSNVisibilityMonitor alloc] init];
    return self;
}

- (void) fetchAds:(NSArray<CSNAdRequest *> *)adRequests completed:(void (^)(NSArray<CSNOptionalAd *> *))completed {
    CSNPAdRequests *adRequestsMessage = [self buildRequestsMessage:adRequests];
    [_client getAds:adRequestsMessage success:^(CSNPAdResponses *adResponsesMessage) {
        NSArray *ads = [self buildAds:adRequests response:adResponsesMessage];
        completed(ads);
    } failure:^(NSError *error) {
        // on failure, log
        NSLog(@"CSNAdsController fetch ads failed, cause %@", error);
    }];
}

- (CSNPAdRequests *) buildRequestsMessage:(NSArray<CSNAdRequest *> *)adRequests {
    NSMutableDictionary *uniqueAdRequests = [[NSMutableDictionary alloc] initWithCapacity:[adRequests count]];
    CSNPAdRequests *adRequestsMsg = [[CSNPAdRequests alloc] init];
    for(id adRequest in adRequests) {
        NSData *requestSha = [adRequest sha256];
        CSNPAdRequest *adRequestMsg = [uniqueAdRequests objectForKey:requestSha];
        if(adRequestMsg) {
            [adRequestMsg setNumOfAds:[adRequestMsg numOfAds] + 1];
        } else {
            adRequestMsg = [[CSNPAdRequest alloc] init];
            [adRequestMsg setHashId:requestSha];
            [adRequestMsg setNumOfAds:1];
            for(id agency in [[adRequest agencies] array]) {
                CSNPTransitAgency *transitAgency = [[CSNPTransitAgency alloc] init];
                [transitAgency setAgencyId:[agency agencyID]];
                [[adRequestMsg agenciesArray] addObject:transitAgency];
            }
            for(id route in [[adRequest routes] array]) {
                CSNPTransitRoute *transitRoute = [[CSNPTransitRoute alloc] init];
                [transitRoute setAgencyId:[route agencyID]];
                [transitRoute setRouteId:[route routeID]];
                [[adRequestMsg routesArray] addObject:transitRoute];
            }
            for(id stop in [[adRequest stops] array]) {
                CSNPTransitStop *transitStop = [[CSNPTransitStop alloc] init];
                [transitStop setAgencyId:[stop agencyID]];
                [transitStop setRouteId:[stop routeID]];
                [transitStop setStopId:[stop stopID]];
                [[adRequestMsg stopsArray] addObject:transitStop];
            }
            [uniqueAdRequests setObject:adRequestMsg forKey:requestSha];
            [[adRequestsMsg adRequestsArray] addObject:adRequestMsg];
        }
    }
    return adRequestsMsg;
}

- (NSArray<CSNOptionalAd *> *) buildAds:(NSArray<CSNAdRequest *> *)adRequests response:(CSNPAdResponses *)adResponses {
    NSMutableDictionary *hashedIndices = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *hashedResponses = [[NSMutableDictionary alloc] init];
    NSMutableArray<CSNOptionalAd *> *ads = [[NSMutableArray alloc] initWithCapacity:[adRequests count]];
    for(id adResponse in [adResponses adResponsesArray]) {
        [hashedResponses setObject:adResponse forKey:[adResponse hashId]];
        [hashedIndices setObject:[NSNumber numberWithUnsignedInteger:0] forKey:[adResponse hashId]];
    }
    for(id adRequest in adRequests) {
        NSData *hash = [adRequest sha256];
        NSNumber *index = [hashedIndices objectForKey:hash];
        NSUInteger indexval = [index unsignedIntegerValue];
        CSNPAdResponse *response = [hashedResponses objectForKey:hash];
        if(index && response && indexval < [response adsArray_Count]) {
            
            CSNPNativeAd *adMessage = [[response adsArray] objectAtIndex:indexval];

            CSNAd *ad = [[CSNAd alloc] initWithMessage:adMessage];
            CSNOptionalAd *optionalAd = [[CSNOptionalAd alloc] initWithAd:ad];
            [ads addObject:optionalAd];
            [hashedIndices setObject:[NSNumber numberWithUnsignedInteger:indexval+1] forKey:hash];
        } else {
            CSNOptionalAd *optionalAd = [[CSNOptionalAd alloc] initWithoutAd];
            [ads addObject:optionalAd];
        }
    }
    return ads;
}

- (void) buildView:(UIView *)view ad:(CSNAd *)ad {
    if(ad != nil) {
        [self setupComponentViews:view ad:ad];
    }
}

- (NSArray *) componentViews:(UIView *)parent {
    return [self findViews:parent matcher:^bool(UIView *view) {
        return [view conformsToProtocol:@protocol(CSNComponentView)];
    }];
}

- (NSArray *) findViews:(UIView *)parent matcher:(bool (^)(UIView *))matcher {
    NSMutableArray *views = [[NSMutableArray alloc] init];
    [self findViews:parent views:views matcher:matcher];
    return views;
}

- (void) findViews:(UIView *)parent views:(NSMutableArray *)views matcher:(bool (^)(UIView *))matcher {
    if([[parent subviews] count] == 0) {
        return;
    }
    for(id subview in [parent subviews]) {
        if(matcher(subview)) {
            [views addObject:subview];
        }
        [self findViews:subview views:views matcher:matcher];
    }
}

- (void) setupComponentViews:(UIView *)parent ad:(CSNAd *)ad {
    for(id<CSNComponentView> componentView in [self componentViews:parent]) {
        // periodically poll view for visibility
        [componentView setAd:ad];
        [componentView addTapHandler:^{
            NSLog(@"%@", [ad body]);
            CGRect bounds = [[UIScreen mainScreen] bounds];
            CSNModalWindow *modalWindow = [[CSNModalWindow alloc] initWithFrame:bounds forAd:ad];
            modalWindow.windowLevel = UIWindowLevelAlert;
            [_visMonitor addView:[modalWindow getSecondaryActionView]];
            modalWindowView = modalWindow;
            [modalWindow makeKeyAndVisible];
            
        }];
        [_visMonitor addView:componentView];
        //[_visibilityMonitor addView:componentView ad:ad];
        //[_interactionMonitor addView:componentView ad:ad];
    }
}

@end
