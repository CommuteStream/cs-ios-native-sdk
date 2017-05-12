@import UIKit;
#import "CSNBodyView.h"

@implementation CSNBodyView

-(instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

- (void) setAd:(CSNAd *)ad {
    _ad = ad;
    _componentID = [[ad body] componentID];
    [self setText:[[ad body] body]];
    [self setNeedsDisplay];
}

@end
