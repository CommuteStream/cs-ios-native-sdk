@import UIKit;
#import "CSNTitleView.h"

@interface CSNTitleView ()
@property (strong, nonatomic) IBOutlet UILabel *labelView;
@property (strong, nonatomic) UIView *containerView;
@end



@implementation CSNTitleView

-(instancetype)initWithCoder:(NSCoder *)decoder {
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
    [_labelView setText:[[ad title] title]];
}

- (void) commonInit {
    NSBundle *bundle = [NSBundle bundleForClass:[CSNTitleView class]];
    CSNTitleView *view = [bundle loadNibNamed:@"CSNTitleView" owner:self options:nil].firstObject;
    if(view != nil) {
        _containerView = view;
        _labelView = [view labelView];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:view];
        [self setNeedsUpdateConstraints];
    }
}



@end
