@import UIKit;
#import "CSNComponentView.h"
#import "CSNAdReportsBuilder.h"
#import "CSNAd.h"

@interface CSNSecondaryActionView : UIView<CSNComponentView, UIGestureRecognizerDelegate>
@property (readonly, nonnull) CSNAd *ad;
@property (readonly) uint64_t componentID;
@property BOOL interactable;
- (void) setAd:(CSNAd * _Nonnull)ad;

- (nullable id) initWithFrame:(CGRect)aRect forAd:(CSNAd * _Nonnull)nativeAd withReportsBuilder:(CSNAdReportsBuilder * _Nonnull)reportsBuilder;

@end
