@import UIKit;
@import WebKit;
#import "CSNComponentView.h"
#import "CSNAd.h"

//IB_DESIGNABLE
@interface CSNHeroView : UIView <CSNComponentView, UIGestureRecognizerDelegate, WKNavigationDelegate>
@property (readonly, nonnull) CSNAd *ad;
@property (readonly) uint64_t componentID;
@property BOOL interactable;
- (void) setAd:(CSNAd * _Nonnull)ad;
@end
