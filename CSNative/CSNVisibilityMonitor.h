@import Foundation;
#import "CSNComponentView.h"
#import "CSNAdReportsBuilder.h"

@interface CSNVisibilityMonitor : NSObject
- (instancetype) initWithReportsBuilder:(CSNAdReportsBuilder *)reportsBuilder;
- (void) start;
- (void) stop;
- (void) addView:(id<CSNComponentView>)componentView;
@end
