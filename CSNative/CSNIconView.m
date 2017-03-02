#import "CSNIconView.h"

@interface CSNIconView ()
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation CSNIconView

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

- (void)setAd:(CSNAd *)ad {
    _ad = ad;
    _componentID = [[ad icon] componentID];
    [self setImage:[[ad icon] image]];
}

- (void) commonInit {
    if(_containerView != nil) {
        return;
    }
    
    UIView *view = nil;
    NSBundle *bundle = [NSBundle bundleForClass:[CSNIconView class]];
    NSArray *objects = [bundle loadNibNamed:@"CSNIconView" owner:self options:nil];
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

- (void) setImage:(UIImage *)image {
    [[self imageView] setImage:image];
    [[self imageView] sizeToFit];
    [self setNeedsUpdateConstraints];
}


@end
