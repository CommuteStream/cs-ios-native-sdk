@import Foundation;
#import "Csnmessages.pbobjc.h"

@interface CSNClientInfo : NSObject
@property NSUUID *adUnit;
@property CSNPDeviceID *deviceID;
@property NSArray<NSData *> *ipAddresses;
@property NSString *timeZone;

- (instancetype) initWithAdUnit:(NSUUID*)adUnit;

- (NSData *) getAdUnitData;

- (void) updateDeviceID;
- (void) updateIpAddresses;
@end

