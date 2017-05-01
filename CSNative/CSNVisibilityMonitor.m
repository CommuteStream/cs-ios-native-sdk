#import "CSNVisibilityMonitor.h"

@interface CSNVisibilityMonitor ()
@property NSHashTable<id<CSNComponentView>> *componentViews;
@property NSTimer *timer;
@end

@implementation CSNVisibilityMonitor

- (instancetype) init {
    _componentViews = [NSHashTable hashTableWithOptions:NSHashTableStrongMemory];
    [self start];
    return self;
}

- (void) start {
    _timer = [NSTimer timerWithTimeInterval:0.1 repeats:true block:^(NSTimer * _Nonnull timer) {
        [self checkViews];
    }];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

- (void) stop {
    
}

- (void) addView:(id<CSNComponentView>)componentView {
    [_componentViews addObject:componentView];
}

- (void) checkViews {
    NSLog(@"checking %lu views for visibility", (unsigned long)[_componentViews count]);
    for(id componentView in _componentViews) {
        UIView *view = (UIView *)componentView;
        CGRect viewFrame = view.frame;
        CGRect windowFrame = view.window.frame;
        CGRect intersected = CGRectIntersection(viewFrame, windowFrame);
        int64_t intersectedArea = intersected.size.width*intersected.size.height;
        int64_t windowArea = windowFrame.size.width * windowFrame.size.height;
        int64_t viewArea = viewFrame.size.width * viewFrame.size.height;
        double viewVisible = 0;
        double deviceVisible = 0;
        if(viewArea > 0 && windowArea > 0) {
            viewVisible = (double)intersectedArea / (double)viewArea;
            deviceVisible = (double)intersectedArea / (double)windowArea;
            //NSLog(@"component view %@ for component %lld  view visible pct %f, window visible pct %f", view, [componentView componentID], viewVisible, deviceVisible);
        }
        uint64_t componentID = [componentView componentID];
        uint64_t adID = [componentView adID];
        [self recordVisibility:adID componentID:componentID viewVisibility:viewVisible deviceVisibility:deviceVisible];
    }
}

- (void) recordVisibility:(uint64_t)adID componentID:(uint64_t)componentID viewVisibility:(double)viewVisibility deviceVisibility:(double)deviceVisibility {
    
}

@end
