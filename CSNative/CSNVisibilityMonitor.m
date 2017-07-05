#import "CSNVisibilityMonitor.h"

@interface CSNVisibilityMonitor ()
@property CSNAdReportsBuilder *reportsBuilder;
@property NSHashTable<id<CSNComponentView>> *componentViews;
@property NSTimer *timer;
@end

@implementation CSNVisibilityMonitor

- (instancetype) initWithReportsBuilder:(CSNAdReportsBuilder *)reportsBuilder {
    _componentViews = [NSHashTable hashTableWithOptions:NSHashTableWeakMemory];
    _reportsBuilder = reportsBuilder;
    [self start];
    return self;
}

- (void) start {
    _timer = [NSTimer timerWithTimeInterval:0.25 target:self selector:@selector(checkViews) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

- (void) stop {
    
}

- (void) addView:(id<CSNComponentView>)componentView {
    [_componentViews addObject:componentView];
}

- (void) checkViews {
    for(id componentView in _componentViews) {
        UIView *view = (UIView *)componentView;
        bool hidden = view.hidden;
        CGRect viewFrame = view.frame;
        CGRect windowFrame = view.window.frame;
        CGRect intersected = CGRectIntersection(viewFrame, windowFrame);
        int64_t intersectedArea = intersected.size.width*intersected.size.height;
        int64_t windowArea = windowFrame.size.width * windowFrame.size.height;
        int64_t viewArea = viewFrame.size.width * viewFrame.size.height;
        double viewVisible = 0;
        double deviceVisible = 0;
        bool isActive = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
        if(viewArea > 0 && windowArea > 0 && !hidden && isActive) {
            viewVisible = (double)intersectedArea / (double)viewArea;
            deviceVisible = (double)intersectedArea / (double)windowArea;
        }
        uint64_t requestID = [[componentView ad] requestID];
        uint64_t adID = [[componentView ad] adID];
        uint64_t versionID = [[componentView ad] versionID];
        uint64_t componentID = [componentView componentID];
        [_reportsBuilder recordVisibility:requestID adID:adID versionID:versionID componentID:componentID viewVisibility:viewVisible deviceVisibility:deviceVisible];
    }
}

@end
