@import Foundation;

@interface CSNImpressionDetector : NSObject
- (instancetype) init;
- (bool) recordVisibility:(uint64_t)requestID adID:(uint64_t)adID versionID:(uint64_t)versionID componentID:(uint64_t)componentID viewVisibility:(double)viewVisiblity deviceVisibility:(double)deviceVisibility;
- (bool) recordInteraction:(uint64_t)requestID adID:(uint64_t)adID versionID:(uint64_t)versionID componentID:(uint64_t)componentID interactionKind:(int32_t)interactionKind;
@end
