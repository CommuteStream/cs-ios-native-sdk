#import "CSNIconView.h"

@implementation CSNIconView

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
    _componentID = [[ad icon] componentID];
    [self setImage:[[ad icon] image]];
    [self setNeedsDisplay];
}

@end
