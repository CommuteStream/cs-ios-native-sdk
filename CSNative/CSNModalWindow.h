#import <UIKit/UIKit.h>
#import "CSNAd.h"
#import "CSNComponentView.h"
@interface CSNModalWindow : UIWindow<UIGestureRecognizerDelegate>

- (id<CSNComponentView>)getSecondaryActionView;
- (id) initWithFrame:(CGRect)frame forAd:(CSNAd *)nativeAd;

@end
