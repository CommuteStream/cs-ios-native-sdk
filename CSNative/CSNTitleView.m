#import "CSNTitleView.h"

@implementation CSNTitleView

- (instancetype) initWithAd:(CSNAd *)ad {
    _ad = ad;
    _componentID = [[ad title] componentID];
    return self;
}


@end
