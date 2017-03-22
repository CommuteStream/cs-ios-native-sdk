#import "CSNAd.h"

@implementation CSNTitleComponent

- (instancetype) initWithMessage:(CSNPTitleComponent *)message {
    _componentID = [message componentId];
    _title = [message title];
    return self;
}

@end


@implementation CSNTransitTitleComponent

- (instancetype) initWithMessage:(CSNPTransitTitleComponent *)message {
    _componentID = [message componentId];
    _title = [message title];
    return self;
}

@end

@implementation CSNTransitSubtitleComponent

- (instancetype) initWithMessage:(CSNPTransitSubtitleComponent *)message {
    _componentID = [message componentId];
    _subtitle = [message subtitle];
    return self;
}

@end


@implementation CSNDescriptionComponent

- (instancetype) initWithMessage:(CSNPDescriptionComponent *)message {
    _componentID = [message componentId];
    _adDescription = [message adDescription];
    return self;
}

@end

@implementation CSNWebUrlComponent

- (instancetype) initWithMessage:(CSNPWebUrlComponent *)message {
    _componentID = [message componentId];
    _websiteURL = [message websiteURL];
    return self;
}

@end

@implementation CSNIconComponent

- (instancetype) initWithMessage:(CSNPIconComponent *)message {
    _componentID = [message componentId];
    _image = [UIImage imageWithData:[message image]];
    return self;
}

@end

@implementation CSNHeroComponent

- (instancetype) initWithMessage:(CSNPHeroComponent *)message {
    _componentID = [message componentId];
    _kind = [message kind];
    
    if(_kind == CSNPHeroKind_Image){
        _image = [UIImage imageWithData:[message blob]];
    }else if(_kind == CSNPHeroKind_Html){
        //TODO: Decode blob to nsstring
        _html = @"";
    }
    
    return self;
}

@end


@implementation CSNAd

- (instancetype) initWithMessage:(CSNPNativeAd *)message {
    _adID = [message adId];
    _requestID = [message requestId];
    _title = [[CSNTitleComponent alloc] initWithMessage:[message title]];
    _transitTitle = [[CSNTransitTitleComponent alloc] initWithMessage:[message transitTitle]];
    _transitSubtitle = [[CSNTransitSubtitleComponent alloc] initWithMessage:[message transitSubtitle]];
    _adDescription = [[CSNDescriptionComponent alloc] initWithMessage:[message adDescription]];
    _websiteURL = [[CSNWebUrlComponent alloc] initWithMessage:[message websiteURL]];
    _icon = [[CSNIconComponent alloc] initWithMessage:[message icon]];
    _hero = [[CSNHeroComponent alloc] initWithMessage:[message hero]];
    return self;
}

@end
