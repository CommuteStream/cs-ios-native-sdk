#import "CSNIconView.h"

@interface CSNIconView ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CSNIconView

-(instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

- (instancetype) initWithAd:(CSNAd *)ad {
    return self;
}

- (void) setImage:(UIImage *)image {
    [[self imageView] setImage:image];
    [[self imageView] sizeToFit];
}


@end
