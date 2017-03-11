#import "CSNAd.h"

@implementation CSNTitleComponent

- (instancetype) initWithMessage:(CSNPTitleComponent *)message {
    _componentID = [message componentId];
    _title = [message title];
    return self;
}

@end

@implementation CSNIconComponent

- (instancetype) initWithMessage:(CSNPIconComponent *)message {
    _componentID = [message componentId];
    NSLog(@"setting image %@", [message image]);
    _image = [UIImage imageWithData:[message image]];
    return self;
}

@end


@implementation CSNAd

- (instancetype) initWithMessage:(CSNPNativeAd *)message {
    _adID = [message adId];
    _requestID = [message requestId];
    _title = [[CSNTitleComponent alloc] initWithMessage:[message title]];
    _icon = [[CSNIconComponent alloc] initWithMessage:[message icon]];
    return self;
}

@end
