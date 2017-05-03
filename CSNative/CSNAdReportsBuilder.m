#import "CSNAdReportsBuilder.h"

@interface CSNAdReportsBuilder ()
@property NSData *adUnit;
@property NSData *deviceID;
@property NSData *ipAddress;
@property NSString *timeZone;
@property CSNPAdReports *adReports;
@property uint64_t epoch;
@end

@implementation CSNAdReportsBuilder

- (instancetype) initWithAdUnit:(NSData *)adUnit deviceID:(NSData *)deviceID ipAddress:(NSData *)ipAddress timeZone:(NSString *)timeZone {
    _adUnit = adUnit;
    _deviceID = deviceID;
    _ipAddress = ipAddress;
    _timeZone = timeZone;
    _epoch = [self currentTime];
    _adReports = [self createAdReports];
    return self;
}

- (void) recordInteraction:(uint64_t)requestID adID:(uint64_t)adID componentID:(uint64_t)componentID interactionKind:(int32_t)interactionKind {
    CSNPAdReport *adReport = [self getAdReport:_adReports requestID:requestID adID:adID];
    CSNPComponentReport *compReport = [self getComponentReport:adReport componentID:componentID];
    [self addComponentInteraction:compReport interactionKind:interactionKind];

}

- (void) recordVisibility:(uint64_t)requestID adID:(uint64_t)adID componentID:(uint64_t)componentID viewVisibility:(double)viewVisiblity deviceVisibility:(double)deviceVisibility {
    CSNPAdReport *adReport = [self getAdReport:_adReports requestID:requestID adID:adID];
    CSNPComponentReport *compReport = [self getComponentReport:adReport componentID:componentID];
    [self addComponentVisibility:compReport viewVisibility:viewVisiblity deviceVisibility:deviceVisibility];
}

- (CSNPAdReports *) buildReport {
    CSNPAdReports *adReports = _adReports;
    _adReports = [self createAdReports];
    return adReports;
    
}

// return the current device time in milliseconds since the unix epoch
- (uint64_t) currentTime {
    return (uint64_t)([[NSDate date] timeIntervalSince1970] * 1000.0);
}

- (CSNPAdReports *) createAdReports {
    CSNPDeviceID *deviceID = [[CSNPDeviceID alloc] init];
    [deviceID setDeviceIdType:CSNPDeviceID_Type_Idfa];
    [deviceID setDeviceId:_deviceID];
    CSNPAdReports *adReports = [[CSNPAdReports alloc] init];
    [adReports setAdUnit:_adUnit];
    [adReports setDeviceId:deviceID];
    [adReports setIpAddr:_ipAddress];
    [adReports setTimezone:_timeZone];
    [adReports setDeviceTime:[self currentTime]];
    return adReports;
}

- (void) addComponentInteraction:(CSNPComponentReport *)compReport interactionKind:(int32_t)interactionKind {
    CSNPComponentInteraction *compInteraction = [[CSNPComponentInteraction alloc] init];
    [compInteraction setKind:interactionKind];
    [compInteraction setDeviceTime:[self currentTime]];
    [[compReport interactionsArray] addObject:compInteraction];
}

- (CSNPAdReport *) findAdReport:(CSNPAdReports *)adReports requestID:(uint64_t)requestID adID:(uint64_t)adID {
    for (id adReport in [_adReports adReportsArray]) {
        if([adReport adId] == adID && [adReport requestId] == requestID) {
            return adReport;
        }
    }
    return nil;
}

- (CSNPAdReport *) getAdReport:(CSNPAdReports *)adReports requestID:(uint64_t)requestID adID:(uint64_t)adID {
    CSNPAdReport *adReport = [self findAdReport:adReports requestID:requestID adID:adID];
    if(adReport){
        return adReport;
    } else {
        adReport = [self createAdReport:requestID adID:adID];
        [[adReports adReportsArray] addObject:adReport];
        return adReport;
    }
}

- (CSNPComponentReport *) findComponentReport:(CSNPAdReport *)adReport componentID:(uint64_t)componentID {
    for(id compReport in [adReport componentsArray]) {
        if([compReport componentId] == componentID) {
            return compReport;
        }
    }
    return nil;
}

- (CSNPComponentReport *) getComponentReport:(CSNPAdReport *)adReport componentID:(uint64_t)componentID {
    CSNPComponentReport *compReport = [self findComponentReport:adReport componentID:componentID];
    if(compReport){
        return compReport;
    } else {
        compReport = [self createComponentReport:componentID];
        [[adReport componentsArray] addObject:compReport];
        return compReport;
    }
}

- (void) addComponentVisibility:(CSNPComponentReport *)compReport viewVisibility:(double)viewVisibility deviceVisibility:(double)deviceVisibility {
}

- (CSNPAdReport *) createAdReport:(uint64_t)requestID adID:(uint64_t)adID {
    CSNPAdReport *adReport = [[CSNPAdReport alloc] init];
    [adReport setAdId:adID];
    [adReport setRequestId:requestID];
    return adReport;
}

- (CSNPComponentReport *) createComponentReport:(uint64_t)componentID {
    CSNPComponentReport *compReport = [[CSNPComponentReport alloc] init];
    [compReport setComponentId:componentID];
    return compReport;
}



@end
