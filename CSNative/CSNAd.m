#import "CSNAd.h"

@implementation CSNHeadlineComponent

- (instancetype) initWithMessage:(CSNPHeadlineComponent *)message {
    _componentID = [message componentId];
    _headline = [message headline];
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


@implementation CSNBodyComponent

- (instancetype) initWithMessage:(CSNPBodyComponent *)message {
    _componentID = [message componentId];
    _body = [message body];
    return self;
}

@end

@implementation CSNAdvertiserComponent

- (instancetype) initWithMessage:(CSNPAdvertiserComponent *)message {
    _componentID = [message componentId];
    _advertiser = [message advertiser];
    return self;
}

@end

@implementation CSNLogoComponent

- (instancetype) initWithMessage:(CSNPLogoComponent *)message {
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


@implementation CSNActionComponent

- (instancetype) initWithMessage:(CSNPActionComponent *)message {
    _componentID = [message componentId];
    _kind = [message kind];
    _title = [message title];
    _url = [message URL];
    _color = [NSKeyedUnarchiver unarchiveObjectWithData:[message color]];
    
    
    return self;
}

@end


@implementation CSNAd

- (instancetype) initWithMessage:(CSNPNativeAd *)message {
    _adID = [message adId];
    _requestID = [message requestId];
    _headline = [[CSNHeadlineComponent alloc] initWithMessage:[message headline]];
    _transitTitle = [[CSNTransitTitleComponent alloc] initWithMessage:[message transitTitle]];
    _transitSubtitle = [[CSNTransitSubtitleComponent alloc] initWithMessage:[message transitSubtitle]];
    _body = [[CSNBodyComponent alloc] initWithMessage:[message body]];
    _advertiser = [[CSNAdvertiserComponent alloc] initWithMessage:[message advertiser]];
    _logo = [[CSNLogoComponent alloc] initWithMessage:[message logo]];
    _hero = [[CSNHeroComponent alloc] initWithMessage:[message hero]];
    
    NSMutableArray *actions = [[NSMutableArray alloc] initWithCapacity:[message actionsArray_Count]];
    for (id action in [message actionsArray]){
        CSNActionComponent *actionComp = [[CSNActionComponent alloc] initWithMessage:action];
        [actions addObject:actionComp];
        
    }
    _actions = actions;
    return self;
}

@end
