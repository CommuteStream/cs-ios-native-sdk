@import UIKit;
#import "CSNTransitSubtitleView.h"

@implementation CSNTransitSubtitleView

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
    [self setText:[[ad transitSubtitle] subtitle]];
    [self setNeedsDisplay];
}

@end
