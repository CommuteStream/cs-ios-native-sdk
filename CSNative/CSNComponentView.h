#import "CSNAd.h"

@protocol CSNComponentView
@property (readonly, nonnull) CSNAd *ad;
@property (readonly) uint64_t componentID;
- (instancetype _Nonnull) initWithAd:(CSNAd * _Nonnull)ad;
@end
