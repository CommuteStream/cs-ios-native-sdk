#import "CSNStopTuple.h"
#import "Csnmessages.pbobjc.h"

@implementation CSNStopTuple

- (instancetype) initWithMessage:(CSNPStop *)stop {
    [self setAgencyID:[stop agencyId]];
    [self setRouteID:[stop routeId]];
    [self setStopID:[stop stopId]];
    return self;
}

- (instancetype) initWithIDs:(NSString *)agencyID routeID:(NSString *)routeID stopID:(NSString *)stopID {
    [self setAgencyID:agencyID];
    [self setRouteID:routeID];
    [self setStopID:stopID];
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    CSNStopTuple *copy = [[CSNStopTuple alloc] initWithIDs:[self agencyID] routeID:[self routeID] stopID:[self stopID]];
    return copy;
}

- (BOOL)isEqualToStopTuple:(CSNStopTuple *)tuple {
    if(!tuple) {
        return NO;
    }
    return [_agencyID isEqualToString:[tuple agencyID]] &&
    [_routeID isEqualToString:[tuple routeID]] &&
    [_stopID isEqualToString:[tuple stopID]];
}

- (BOOL)isEqual:(id)object {
    if(self == object) {
        return YES;
    }
    return [self isEqualToStopTuple:object];
}

- (NSUInteger)hash {
    return [self.agencyID hash] ^ [self.routeID hash] ^ [self.stopID hash];
}

@end
