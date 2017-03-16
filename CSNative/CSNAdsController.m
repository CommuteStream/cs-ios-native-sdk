#import "CSNAdsController.h"
#import "CSNClient.h"
#import "CSNHttpClient.h"
#import "CSNMockClient.h"
#import "CSNIconView.h"
#import "CSNStopTuple.h"
#import "CSNVisibilityMonitor.h"
#import "Csnmessages.pbobjc.h"

@interface CSNAdsController ()
@property id<CSNClient> client;
@property CSNVisibilityMonitor *visMonitor;
@property NSMutableDictionary *stopAds;
@property NSMutableDictionary *ads;
@end

@implementation CSNAdsController

- (instancetype) init {
    return [self initWithClient:[[CSNHttpClient alloc] initWithHost:@"api.commutestream.com"]];
}

- (instancetype) initMocked {
    return [self initWithClient:[[CSNMockClient alloc] init]];
}

- (instancetype) initWithClient:(id<CSNClient>)client {
    _client = client;
    _stopAds = [[NSMutableDictionary alloc] init];
    _ads = [[NSMutableDictionary alloc] init];
    _visMonitor = [[CSNVisibilityMonitor alloc] init];
    return self;
}

- (void) fetchAds:(CSNAdRequest *)request completed:(void (^)(void))completed {
    // build CSNPAdRequest with stops we don't yet have
    NSMutableSet *keysInRequest = [NSMutableSet setWithSet:[request stops]];
    NSSet *keysInCache = [NSMutableSet setWithArray:[_stopAds allKeys]];
    [keysInRequest minusSet:keysInCache];
    if([keysInRequest count] == 0) {
        return completed();
    }
    CSNPAdRequest *adRequest = [[CSNPAdRequest alloc] init];
    for(id key in keysInRequest) {
        CSNPStop *stop = [[CSNPStop alloc] init];
        [stop setAgencyId:[key agencyID]];
        [stop setRouteId:[key routeID]];
        [stop setStopId:[key stopID]];
        [[adRequest stopsArray] addObject:stop];
    }
    [_client getAds:adRequest success:^(CSNPAdResponse *response) {
        [self cacheAds:response];
        completed();
    } failure:^(NSError *error) {
        // on failure, log
        NSLog(@"CSNAdsController fetch ads failed, cause %@", error);
    }];
}

- (void) buildStopAd:(UIView *)view agencyID:(NSString *)agencyID routeID:(NSString *)routeID stopID:(NSString *)stopID {
    CSNStopTuple *stopTuple = [[CSNStopTuple alloc] initWithIDs:agencyID routeID:routeID stopID:stopID];
    NSNumber *adID = [_stopAds objectForKey:stopTuple];
    if(adID == nil) {
        return;
    }
    CSNAd *ad = [_ads objectForKey:adID];
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

- (void) cacheAds:(CSNPAdResponse *)response {
    for(id stopAd in [response stopAdsArray]) {
        CSNPStop *stop = [stopAd stopTuple];
        CSNStopTuple *stopTuple = [[CSNStopTuple alloc] initWithMessage:stop];
        CSNPNativeAd *message = [[response ads] objectForKey:[stopAd adId]];
        CSNAd *ad = [[CSNAd alloc] initWithMessage:message];
        if(ad != nil) {
            NSNumber *adID = [NSNumber numberWithUnsignedLongLong:[ad adID]];
            [_stopAds setObject:adID forKey:stopTuple];
            [_ads setObject:ad forKey:adID];
        }
    }
}

- (void) setupComponentViews:(UIView *)parent ad:(CSNAd *)ad {
    for(id<CSNComponentView> componentView in [self componentViews:parent]) {
        // periodically poll view for visibility
        [componentView setAd:ad];
        [_visMonitor addView:componentView];
        //[_visibilityMonitor addView:componentView ad:ad];
        //[_interactionMonitor addView:componentView ad:ad];
    }
}

@end
