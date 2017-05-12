@import UIKit;
#import "CSNTransitTitleView.h"

@implementation CSNTransitTitleView

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
    _componentID = [[ad transitTitle] componentID];
    [self setText:[[ad transitTitle] title]];
    [self setNeedsDisplay];
}

@end
