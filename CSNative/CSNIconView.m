#import "CSNIconView.h"

@interface CSNIconView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) UIView *containerView;
@end

@implementation CSNIconView

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

- (void)setAd:(CSNAd *)ad {
    _ad = ad;
    _componentID = [[ad icon] componentID];
    [self setImage:[[ad icon] image]];
}

- (void) commonInit {
    NSBundle *bundle = [NSBundle bundleForClass:[CSNIconView class]];
    CSNIconView *view = [bundle loadNibNamed:@"CSNIconView" owner:self options:nil].firstObject;
    if(view != nil) {
        _containerView = view;
        _iconView = [view iconView];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:view];
        [self setNeedsUpdateConstraints];
    }
}

- (void) setImage:(UIImage *)image {
    [_iconView setImage:image];
    [_iconView sizeToFit];
    [self setNeedsUpdateConstraints];
}


@end
