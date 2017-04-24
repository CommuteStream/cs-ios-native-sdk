@import UIKit;
#import "CSNComponentView.h"
#import "CSNAd.h"

@interface CSNActionView : UIButton<CSNComponentView, UIGestureRecognizerDelegate>
@property (readonly, nonnull) CSNAd *ad;
@property (readonly) uint64_t componentID;
@property BOOL interactable;
- (void) setAd:(CSNAd * _Nonnull)ad;
- (void) setAd:(CSNAd * _Nonnull)ad atActionIndex:(NSUInteger)index;

@end
