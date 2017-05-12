#import "CSNLogoView.h"

@implementation CSNLogoView

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
    _componentID = [[ad logo] componentID];
    [self setImage:[[ad logo] image]];
    [self setNeedsDisplay];
}

@end
