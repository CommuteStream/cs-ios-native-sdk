#import "CSNIconView.h"

@implementation CSNIconView

-(instancetype)initWithCoder:(NSCoder *)decoder {
    NSLog(@"Icon view init with coder");
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
    NSLog(@"%f,%f %fx%f", self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

@end
