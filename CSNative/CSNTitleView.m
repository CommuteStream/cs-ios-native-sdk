#import "CSNTitleView.h"

@implementation CSNTitleView

- (void) setAd:(CSNAd *)ad {
    _ad = ad;
    _componentID = [[ad title] componentID];
}


@end
