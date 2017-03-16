#import "CSNAdRequest.h"
#import "CSNStopTuple.h"

@implementation CSNAdRequest

- (instancetype) init {
    _stops = [[NSMutableSet alloc] init];
    return self;
}

- (void) addStop:(NSString *)agencyID routeID:(NSString *)routeID stopID:(NSString *)stopID {
    CSNStopTuple *stop = [[CSNStopTuple alloc] initWithIDs:agencyID routeID:routeID stopID:stopID];
    [_stops addObject:stop];
}

@end
