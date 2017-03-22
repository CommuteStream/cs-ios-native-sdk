@import UIKit;
#import "CSNAd.h"
#import "CSNComponentView.h"

//IB_DESIGNABLE
@interface CSNTransitTitleView : UILabel <CSNComponentView, UIGestureRecognizerDelegate>
@property (readonly, nonnull) CSNAd *ad;
@property (readonly) uint64_t componentID;
@property BOOL interactable;
- (void) setAd:(CSNAd * _Nonnull)ad;
@end
