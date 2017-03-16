#import "CSNAd.h"

@protocol CSNComponentView
@property (readonly, nonnull) CSNAd *ad;
@property (readonly) uint64_t componentID;
@property BOOL interactable;
- (void) setAd:(CSNAd * _Nonnull)ad;
@end
