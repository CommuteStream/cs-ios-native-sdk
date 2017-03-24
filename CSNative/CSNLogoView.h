@import UIKit;
#import "CSNComponentView.h"
#import "CSNAd.h"

//IB_DESIGNABLE
@interface CSNLogoView : UIImageView <CSNComponentView, UIGestureRecognizerDelegate>
@property (readonly, nonnull) CSNAd *ad;
@property (readonly) uint64_t componentID;
@property BOOL interactable;
- (void) setAd:(CSNAd * _Nonnull)ad;
@end
