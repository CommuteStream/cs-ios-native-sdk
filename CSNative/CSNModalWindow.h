#import <UIKit/UIKit.h>
#import "CSNAd.h"
#import "CSNComponentView.h"
#import "CSNAdReportsBuilder.h"

@interface CSNModalWindow : UIWindow<UIGestureRecognizerDelegate>

- (id<CSNComponentView>)getSecondaryActionView;
- (id) initWithFrame:(CGRect)frame forAd:(CSNAd *)nativeAd withReportsBuilder:(CSNAdReportsBuilder *)reportsBuilder;

@end
