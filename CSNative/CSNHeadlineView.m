@import UIKit;
#import "CSNHeadlineView.h"

@implementation CSNHeadlineView

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
    _componentID = [[ad headline] componentID];
    [self setText:[[ad headline] headline]];
    [self setNeedsDisplay];
}

@end
