@import UIKit;
#import "CSNTitleView.h"

@interface CSNTitleView ()
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (strong, nonatomic) UIView *containerView;
@end



@implementation CSNTitleView

-(instancetype)initWithCoder:(NSCoder *)decoder {
    NSLog(@"init with coder");
    self = [super initWithCoder:decoder];
    if(self && self.subviews.count == 0) {
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self && self.subviews.count == 0) {
        [self commonInit];
    }
    return self;
}


- (void) setAd:(CSNAd *)ad {
    _ad = ad;
    _componentID = [[ad title] componentID];
    NSLog(@"setting text on title view %@", _titleView);
    [_titleView setText:[[ad title] title]];
}

- (void) commonInit {
    if(_containerView != nil) {
        return;
    }
    NSLog(@"common");
    
    NSBundle *bundle = [NSBundle bundleForClass:[CSNTitleView class]];
    CSNTitleView *view = [bundle loadNibNamed:@"CSNTitleView" owner:self options:nil].firstObject;
    
    if(view != nil) {
        _containerView = view;
        _titleView = [view viewWithTag:1];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:view];
        [self setNeedsUpdateConstraints];
    }
    
}



@end
