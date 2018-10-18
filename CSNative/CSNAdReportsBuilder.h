@import Foundation;

#import "Csnmessages.pbobjc.h"
#import "CSNClientInfo.h"

@interface CSNAdReportsBuilder : NSObject
- (instancetype) initWithClientInfo:(CSNClientInfo *)clientInfo;
- (void) setDeviceID:(CSNPDeviceID *)deviceID;
- (void) setIpAddresses:(NSArray<NSData *>*)ipAddresses;
- (void) setLocations:(NSArray<CSNPDeviceLocation*>*)locations;
- (void) recordVisibility:(uint64_t)requestID adID:(uint64_t)adID versionID:(uint64_t)versionID componentID:(uint64_t)componentID viewVisibility:(double)viewVisiblity deviceVisibility:(double)deviceVisibility;
- (void) recordInteraction:(uint64_t)requestID adID:(uint64_t)adID versionID:(uint64_t)versionID componentID:(uint64_t)componentID interactionKind:(int32_t)interactionKind;
- (CSNPAdReports *) buildReport;
@end
