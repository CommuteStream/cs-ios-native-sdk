@import UIKit;
#import "CSNComponentView.h"
#import "CSNAd.h"

@interface CSNActionView : UIButton<CSNComponentView, UIGestureRecognizerDelegate>
@property (readonly, nonnull) CSNAd *ad;
@property (readonly) uint64_t componentID;
@property BOOL interactable;
@property (nonatomic, nonnull) void (^blockAction)(void);
- (void) addTapHandler:(nullable void(^)(void))callback;
- (void) invokeBlock:(nullable id)sender;
- (void) setAd:(CSNAd * _Nonnull)ad;
- (void) setAd:(CSNAd * _Nonnull)ad atActionIndex:(NSUInteger)index;

@end
