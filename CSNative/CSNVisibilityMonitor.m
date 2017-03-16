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
    NSLog(@"checking views %lu", (unsigned long)[_componentViews count]);
    for(id componentView in _componentViews) {
        UIView *view = (UIView *)componentView;
        CGRect viewFrame = view.frame;
        CGRect windowFrame = view.window.frame;
        CGRect intersected = CGRectIntersection(viewFrame, windowFrame);
        int64_t intersectedArea = intersected.size.width*intersected.size.height;
        int64_t windowArea = windowFrame.size.width * windowFrame.size.height;
        int64_t viewArea = viewFrame.size.width * viewFrame.size.height;
        if(viewArea > 0 && windowArea > 0) {
            double viewVisible = (double)intersectedArea / (double)viewArea;
            double deviceVisible = (double)intersectedArea / (double)windowArea;
            NSLog(@"component view %@ for %lld  view visible pct %f, window visible pct %f", view, [componentView adID], viewVisible, deviceVisible);
        }
        //CGPoint originalPoint = CGPointMake(view.frame.origin.x, view.frame.origin.y);
        // can I just look at the window of the view rather than the superview?
        //CGPoint pointInAppFrame = [view convertPoint:originalPoint toView:view.superview.window];
        //BOOL visible = CGRectIntersectsRect(CGRectMake(pointInAppFrame.x, pointInAppFrame.y, view.frame.size.width, view.frame.size.height), view.superview.window.frame);
        //double pct_of_screen =
        //double pct_visible =
    }
}

@end
