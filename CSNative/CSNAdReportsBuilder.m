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
    bool added = false;
    for (id adReport in [_adReports adReportsArray]) {
        if([adReport adId] == adID && [adReport requestId] == requestID) {
            [self addComponentInteraction:adReport componentID:componentID interactionKind:interactionKind];
            added = true;
            break;
        }
    }
    if(!added) {
        CSNPAdReport *adReport = [self createAdReport:requestID adID:adID];
        [self addComponentInteraction:adReport componentID:componentID interactionKind:interactionKind];
        [[_adReports adReportsArray] addObject:adReport];
    }
}

- (void) recordVisibility:(uint64_t)requestID adID:(uint64_t)adID componentID:(uint64_t)componentID viewVisibility:(double)viewVisiblity deviceVisibility:(double)deviceVisibility {
    
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

- (CSNPAdReport *) createAdReport:(uint64_t)requestID adID:(uint64_t)adID {
    CSNPAdReport *adReport = [[CSNPAdReport alloc] init];
    [adReport setAdId:adID];
    [adReport setRequestId:requestID];
    return adReport;
}

- (void) addComponentInteraction:(CSNPAdReport *)adReport componentID:(uint64_t)componentID interactionKind:(int32_t)interactionKind {
    bool added = false;
    CSNPComponentInteraction *compInteraction = [[CSNPComponentInteraction alloc] init];
    [compInteraction setKind:interactionKind];
    [compInteraction setDeviceTime:[self currentTime]];
    for(id compReport in [adReport componentsArray]) {
        if([compReport componentId] == componentID) {
            [[compReport interactionsArray] addObject:compInteraction];
            added = true;
            break;
        }
    }
    if(!added) {
        CSNPComponentReport *compReport = [self createComponentReport:componentID];
        [[compReport interactionsArray] addObject:compInteraction];
        [[adReport componentsArray] addObject:compReport];
    }
}

- (CSNPComponentReport *) createComponentReport:(uint64_t)componentId {
    CSNPComponentReport *compReport = [[CSNPComponentReport alloc] init];
    [compReport setComponentId:componentId];
    return compReport;
}



@end
