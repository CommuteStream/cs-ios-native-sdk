@import Foundation;
#import "CSNComponentView.h"

@interface CSNVisibilityMonitor : NSObject
- (instancetype) init;
- (void) start;
- (void) stop;
- (void) addView:(id<CSNComponentView>)componentView;
@end
