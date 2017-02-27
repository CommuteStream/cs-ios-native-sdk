#import "CSNAdBuilder.h"
#import "CSNAdView.h"
#import "CSNClient.h"

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


@implementation CSNAdBuilder {
    id<CSNClient> _client;
    NSMutableDictionary *_stopViews;
}

- (instancetype) initWithClient:(id<CSNClient>)client {
    _client = client;
    return self;
}

- (void) addStopNativeAd:(CSNAdView *)view agencyID:(NSString *)agencyID routeID:(NSString *)routeID stopID:(NSString *)stopID {
    CSNStopTuple *stopTuple = [[CSNStopTuple alloc] initWithIDs:agencyID routeID:routeID stopID:stopID];
    [_stopViews setObject:view forKey:stopTuple];
}

- (void) build {
    CSNPAdRequest *adRequest = [[CSNPAdRequest alloc] init];
    for(id key in _stopViews) {
        CSNPStop *stop = [[CSNPStop alloc] init];
        [stop setAgencyId:[key agencyID]];
        [stop setRouteId:[key routeID]];
        [stop setStopId:[key stopID]];
        [[adRequest stopsArray] addObject:stop];
    }
    [_client getAds:adRequest success:^(CSNPAdResponse *response) {
        // for each stop with an ad, build out CSNAdView and associated Controller
    } failure:^(NSError *error) {
        // on failure, log
        NSLog(@"CSNAdBuilder failed, cause %@", error);
    }];
}

@end
