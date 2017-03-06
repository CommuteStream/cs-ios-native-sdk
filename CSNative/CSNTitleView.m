@import UIKit;
#import "CSNTitleView.h"

@interface CSNTitleView ()
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) IBOutlet UILabel *labelView;
@end



@implementation CSNTitleView

-(instancetype)initWithCoder:(NSCoder *)decoder {
    NSLog(@"init with coder");
    self = [super initWithCoder:decoder];
    if(self) {
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self commonInit];
    }
    return self;
}


- (void) setAd:(CSNAd *)ad {
    _ad = ad;
    _componentID = [[ad title] componentID];
}

- (void) commonInit {
    if(_containerView != nil) {
        return;
    }
    
    UIView *view = nil;
    NSBundle *bundle = [NSBundle bundleForClass:[CSNTitleView class]];
    NSArray *objects = [bundle loadNibNamed:@"CSNTitleView" owner:self options:nil];
    for (id object in objects) {
        if ([object isKindOfClass:[UIView class]]) {
            view = object;
            break;
        }
    }
    
    if(view != nil) {
        _containerView = view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:view];
        [self setNeedsUpdateConstraints];
    }
    
}



@end
