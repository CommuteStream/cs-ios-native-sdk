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
@property NSMapTable *stopViews;
@property CSNVisibilityMonitor *visMonitor;
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
    _stopViews = [NSMapTable mapTableWithKeyOptions:NSMapTableStrongMemory valueOptions:NSMapTableWeakMemory];
    _visMonitor = [[CSNVisibilityMonitor alloc] init];
    return self;
}

- (void) addStopAd:(UIView *)view agencyID:(NSString *)agencyID routeID:(NSString *)routeID stopID:(NSString *)stopID {
    CSNStopTuple *stopTuple = [[CSNStopTuple alloc] initWithIDs:agencyID routeID:routeID stopID:stopID];
    [_stopViews setObject:view forKey:stopTuple];
}

- (void) refreshAds {
    CSNPAdRequest *adRequest = [[CSNPAdRequest alloc] init];
    for(id key in _stopViews) {
        CSNPStop *stop = [[CSNPStop alloc] init];
        [stop setAgencyId:[key agencyID]];
        [stop setRouteId:[key routeID]];
        [stop setStopId:[key stopID]];
        [[adRequest stopsArray] addObject:stop];
    }
    [_client getAds:adRequest success:^(CSNPAdResponse *response) {
        [self buildViews:response];
    } failure:^(NSError *error) {
        // on failure, log
        NSLog(@"CSNAdController refresh failed, cause %@", error);
    }];
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

- (void) buildViews:(CSNPAdResponse *)response {
    for(id stopAd in [response stopAdsArray]) {
        CSNPStop *stop = [stopAd stopTuple];
        CSNStopTuple *stopTuple = [[CSNStopTuple alloc] initWithMessage:stop];
        UIView *view = [_stopViews objectForKey:stopTuple];
        if(view != nil) {
            // Build Ad and AdView from Ad Message
            CSNPNativeAd *message = [[response ads] objectForKey:[stopAd adId]];
            CSNAd *ad = [[CSNAd alloc] initWithMessage:message];
            [self initComponentViews:view ad:ad];
        } else {
            NSLog(@"CSNAdController No view found for returned stop tuple");
        }
    }
}

- (void) initComponentViews:(UIView *)parent ad:(CSNAd *)ad {
    for(id<CSNComponentView> componentView in [self componentViews:parent]) {
        // periodically poll view for visibility
        [componentView setAd:ad];
        [_visMonitor addView:componentView];
        //[_visibilityMonitor addView:componentView ad:ad];
        //[_interactionMonitor addView:componentView ad:ad];
    }
}

@end
