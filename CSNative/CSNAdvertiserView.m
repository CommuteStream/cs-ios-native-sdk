@import UIKit;
#import "CSNAdvertiserView.h"

@implementation CSNAdvertiserView

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
    _componentID = [[ad advertiser] componentID];
    [self setText:[[ad advertiser] advertiser]];
    [self setNeedsDisplay];
}

@end
