#import "CSNAd.h"

@protocol CSNComponentView
@property (readonly, nonnull) CSNAd *ad;
@property (readonly) uint64_t componentID;
@property BOOL interactable;
@property (nonatomic, nonnull) void (^blockAction)(void);

- (void) setAd:(CSNAd * _Nonnull)ad;
- (void)addTapHandler:(nullable void(^)(void))callback;
- (void) invokeBlock:(nullable id)sender;



@end
