#import "CSNAdReportsBuilder.h"

@interface CSNAdReportsBuilder ()
@property NSData *adUnit;
@property NSData *deviceID;
@property NSData *ipAddress;
@property NSMutableDictionary<NSNumber*, NSMutableArray*> *componentReports;
@end

@implementation CSNAdReportsBuilder

- (instancetype) initWithAdUnit:(NSData *)adUnit deviceID:(NSData *)deviceID ipAddresss:(NSData *)ipAddress {
    _adUnit = adUnit;
    _deviceID = deviceID;
    _ipAddress = ipAddress;
    return self;
}

- (void) recordInteraction:(uint64_t)requestID adID:(uint64_t)adID componentID:(uint64_t)componentID interactionKind:(uint64_t)interactionKind {

}

- (void) recordVisibility:(uint64_t)requestID adID:(uint64_t)adID componentID:(uint64_t)componentID viewVisibility:(double)viewVisiblity deviceVisibility:(double)deviceVisibility {

}

- (CSNPAdReports *) buildReport {
    return nil;

}

@end
