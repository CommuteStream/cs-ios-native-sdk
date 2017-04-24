#import "CSNTransit.h"
#import "Csnmessages.pbobjc.h"

@implementation CSNTransitAgency

- (instancetype) initWithMessage:(CSNPTransitAgency *)agency {
    [self setAgencyID:[agency agencyId]];
    return self;
}

- (instancetype) initWithIDs:(NSString *)agencyID {
    [self setAgencyID:agencyID];
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    CSNTransitAgency *copy = [[CSNTransitAgency alloc] initWithIDs:[self agencyID]];
    return copy;
}

- (BOOL)isEqualToTransitAgency:(CSNTransitAgency *)agency {
    if(!agency) {
        return NO;
    }
    return [_agencyID isEqualToString:[agency agencyID]];
}

- (BOOL)isEqual:(id)object {
    if(self == object) {
        return YES;
    }
    return [self isEqualToTransitAgency:object];
}

- (NSUInteger)hash {
    return [self.agencyID hash];
}

@end

@implementation CSNTransitRoute

- (instancetype) initWithMessage:(CSNPTransitRoute *)route {
    [self setAgencyID:[route agencyId]];
    [self setRouteID:[route routeId]];
    return self;
}

- (instancetype) initWithIDs:(NSString *)agencyID routeID:(NSString *)routeID {
    [self setAgencyID:agencyID];
    [self setRouteID:routeID];
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    CSNTransitRoute *copy = [[CSNTransitRoute alloc] initWithIDs:[self agencyID] routeID:[self routeID]];
    return copy;
}

- (BOOL)isEqualToTransitRoute:(CSNTransitRoute *)route {
    if(!route) {
        return NO;
    }
    return [_agencyID isEqualToString:[route agencyID]] &&
    [_routeID isEqualToString:[route routeID]];
}

- (BOOL)isEqual:(id)object {
    if(self == object) {
        return YES;
    }
    return [self isEqualToTransitRoute:object];
}

- (NSUInteger)hash {
    return [self.agencyID hash] ^ [self.routeID hash];
}

@end


@implementation CSNTransitStop

- (instancetype) initWithMessage:(CSNPTransitStop *)stop {
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
    CSNTransitStop *copy = [[CSNTransitStop alloc] initWithIDs:[self agencyID] routeID:[self routeID] stopID:[self stopID]];
    return copy;
}

- (BOOL)isEqualToTransitStop:(CSNTransitStop *)stop {
    if(!stop) {
        return NO;
    }
    return [_agencyID isEqualToString:[stop agencyID]] &&
    [_routeID isEqualToString:[stop routeID]] &&
    [_stopID isEqualToString:[stop stopID]];
}

- (BOOL)isEqual:(id)object {
    if(self == object) {
        return YES;
    }
    return [self isEqualToTransitStop:object];
}

- (NSUInteger)hash {
    return [self.agencyID hash] ^ [self.routeID hash] ^ [self.stopID hash];
}

@end
