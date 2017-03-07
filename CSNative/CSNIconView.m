#import "CSNIconView.h"

@interface CSNIconView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) UIView *containerView;
@end

@implementation CSNIconView

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

- (void)setAd:(CSNAd *)ad {
    _ad = ad;
    _componentID = [[ad icon] componentID];
    [self setImage:[[ad icon] image]];
}

- (void) commonInit {
    NSLog(@"Common Init");
    if(_containerView != nil) {
        return;
    }
    
    NSBundle *bundle = [NSBundle bundleForClass:[CSNIconView class]];
    CSNIconView *view = [bundle loadNibNamed:@"CSNIconView" owner:self options:nil].firstObject;
    
    if(view != nil) {
        _containerView = view;
        _iconView = [view viewWithTag:1];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:view];
        [self setNeedsUpdateConstraints];
    }
    NSLog(@"common init done");

}

- (void) setImage:(UIImage *)image {
    [_iconView setImage:image];
    [_iconView sizeToFit];
    [self setNeedsUpdateConstraints];
}


@end
