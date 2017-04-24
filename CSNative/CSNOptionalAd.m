#import "CSNOptionalAd.h"

@implementation CSNOptionalAd

- (instancetype) initWithAd:(CSNAd *)ad {
    _ad = ad;
    return self;
}

- (instancetype) initWithoutAd {
    _ad = NULL;
    return self;
}

@end
