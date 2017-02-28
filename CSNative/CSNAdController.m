#import "CSNAdController.h"
#import "CSNClient.h"
#import "CSNHttpClient.h"
#import "CSNIconView.h"

@interface CSNStopTuple : NSObject <NSCopying>
@property NSString *agencyID;
@property NSString *routeID;
@property NSString *stopID;
@end

@implementation CSNStopTuple
- (instancetype) initWithIDs:(NSString *)agencyID routeID:(NSString *)routeID stopID:(NSString *)stopID {
    [self setAgencyID:agencyID];
    [self setRouteID:routeID];
    [self setStopID:stopID];
    return self;
}
- (id)copyWithZone:(NSZone *)zone {
    CSNStopTuple *copy = [[CSNStopTuple alloc] init];
    [copy setAgencyID:[self agencyID]];
    [copy setRouteID:[self routeID]];
    [copy setStopID:[self stopID]];
    return copy;
}
@end


@implementation CSNAdController {
    id<CSNClient> _client;
    NSMutableDictionary *_stopViews;
}

- (instancetype) init {
    _client = [[CSNHttpClient alloc] initWithHost:@"api.commutestream.com"];
    return self;
}

- (instancetype) initWithClient:(id<CSNClient>)client {
    _client = client;
    return self;
}

- (void) addStopAd:(UIView *)view agencyID:(NSString *)agencyID routeID:(NSString *)routeID stopID:(NSString *)stopID {
    CSNStopTuple *stopTuple = [[CSNStopTuple alloc] initWithIDs:agencyID routeID:routeID stopID:stopID];
    [_stopViews setObject:view forKey:stopTuple];
}

- (void) removeStopAd:(NSString *)agencyID routeID:(NSString *)routeID stopID:(NSString *)stopID {
    
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
    for(id stop in response.stopAdsArray) {
        CSNStopTuple *stopTuple = [[CSNStopTuple alloc] initWithIDs:[stop agencyId] routeID:[stop routeId] stopID:[stop stopId]];
        UIView *view = [_stopViews objectForKey:stopTuple];
        if(view != nil) {
            // Build Ad and AdView from Ad Message
            CSNPNativeAd *message = [[response ads] objectForKey:[stop adId]];
            CSNAd *ad = [[CSNAd alloc] initWithMessage:message];
            for(id<CSNComponentView> componentView in [self componentViews:view]) {
                id<CSNComponentView> _view __unused = [componentView initWithAd:ad];
            }
        }
    }
}

@end
