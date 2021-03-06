#import "CSNAdRequest.h"
#import "CSNTransit.h"
#import <CommonCrypto/CommonCrypto.h>


@interface CSNAdRequest()
@property NSMutableOrderedSet *agencies;
@property NSMutableOrderedSet *routes;
@property NSMutableOrderedSet *stops;
@end

@implementation CSNAdRequest

- (instancetype) init {
    _agencies = [[NSMutableOrderedSet alloc] init];
    _routes = [[NSMutableOrderedSet alloc] init];
    _stops = [[NSMutableOrderedSet alloc] init];
    return self;
}

- (NSData *) sha256 {
    NSMutableData *result = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    CC_SHA256_CTX shactx;
    CC_SHA256_Init(&shactx);
    for(id agency in _agencies) {
        const char *agencyID = [[agency agencyID] UTF8String];
        if(agencyID) {
            CC_SHA256_Update(&shactx, agencyID, (unsigned int)strlen(agencyID));
        }
    }
    for(id route in _routes) {
        const char *agencyID = [[route agencyID] UTF8String];
        if(agencyID) {
            CC_SHA256_Update(&shactx, agencyID, (unsigned int)strlen(agencyID));
        }
        const char *routeID = [[route routeID] UTF8String];
        if(routeID) {
            CC_SHA256_Update(&shactx, routeID, (unsigned int)strlen(routeID));
        }
    }
    for(id stop in _stops) {
        const char *agencyID = [[stop agencyID] UTF8String];
        if(agencyID) {
            CC_SHA256_Update(&shactx, agencyID, (unsigned int)strlen(agencyID));
        }
        const char *routeID = [[stop routeID] UTF8String];
        if(routeID) {
            CC_SHA256_Update(&shactx, routeID, (unsigned int)strlen(routeID));
        }
        const char *stopID = [[stop stopID] UTF8String];
        if(stopID) {
            CC_SHA256_Update(&shactx, stopID, (unsigned int)strlen(stopID));
        }
    }
    CC_SHA256_Final(result.mutableBytes, &shactx);
    return result;
}

- (void) addAgency:(CSNTransitAgency *)agency {
    [_agencies addObject:agency];
}

- (void) addRoute:(CSNTransitRoute *)route {
    [_routes addObject:route];
}

- (void) addStop:(CSNTransitStop *)stop {
    [_stops addObject:stop];
}

- (void) removeUnknownMarkets:(NSSet<NSString *> *)markets {
    NSMutableOrderedSet *newAgencies = [[NSMutableOrderedSet alloc] init];
    NSMutableOrderedSet *newRoutes = [[NSMutableOrderedSet alloc] init];
    NSMutableOrderedSet *newStops = [[NSMutableOrderedSet alloc] init];
    for (CSNTransitAgency *agency in _agencies) {
        if([markets containsObject:[agency agencyID]]) {
            [newAgencies addObject:agency];
        }
    }
    for (CSNTransitRoute *route in _routes) {
        if([markets containsObject:[route agencyID]]) {
            [newRoutes addObject:route];
        }
    }
    for (CSNTransitStop *stop in _stops) {
        if([markets containsObject:[stop agencyID]]) {
            [newStops addObject:stop];
        }
    }
    _agencies = newAgencies;
    _routes = newRoutes;
    _stops = newStops;
}

- (NSUInteger) numOfTargets {
    return [_agencies count] + [_routes count] + [_stops count];
}

@end
