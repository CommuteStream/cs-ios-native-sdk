#import "CSNHeroView.h"

@implementation CSNHeroView

-(instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

- (void)setAd:(CSNAd *)ad {
    _ad = ad;
    _componentID = [[ad hero] componentID];
    UIImageView *heroImageView = [[UIImageView alloc] initWithImage:[[ad hero] image]];
    [heroImageView setFrame: self.bounds];
    [self addSubview:heroImageView];
    [self setNeedsDisplay];
}

@end
