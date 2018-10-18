#import "CSNAd.h"


@implementation CSNColors

- (instancetype) initWithMessage:(CSNPColors *)message {
    _foreground = [self decodeColor:[message foreground]];
    _background = [self decodeColor:[message background]];
    return self;
}

- (UIColor *) decodeColor:(CSNPColor *)color {
    CGFloat red = (CGFloat)[color red]/255.0;
    CGFloat green = (CGFloat)[color green]/255.0;
    CGFloat blue = (CGFloat)[color blue]/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end

@implementation CSNViewComponent

- (instancetype) initWithMessage:(CSNPViewComponent *)message {
    _componentID = [message componentId];
    return self;
}

@end


@implementation CSNHeadlineComponent

- (instancetype) initWithMessage:(CSNPHeadlineComponent *)message {
    _componentID = [message componentId];
    _headline = [message headline];
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

@implementation CSNSecondaryActionComponent

- (instancetype) initWithMessage:(CSNPSecondaryActionComponent *)message {
    _componentID = [message componentId];
    _title = [message title];
    _subtitle = [message subtitle];
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
        _html = [NSString stringWithUTF8String:[[message blob] bytes]];
    }
    _interactive = [message interactive];
    return self;
}

@end


@implementation CSNActionComponent

- (instancetype) initWithMessage:(CSNPActionComponent *)message {
    _componentID = [message componentId];
    _kind = [message kind];
    _title = [message title];
    _url = [message URL];
    _colors = [[CSNColors alloc] initWithMessage:[message colors]];
    return self;
}

@end


@implementation CSNAd

- (instancetype) initWithMessage:(CSNPAd *)message {
    _adID = [message adId];
    _versionID = [message versionId];
    _view = [[CSNViewComponent alloc] initWithMessage:[message view]];
    _headline = [[CSNHeadlineComponent alloc] initWithMessage:[message headline]];
    _body = [[CSNBodyComponent alloc] initWithMessage:[message body]];
    _advertiser = [[CSNAdvertiserComponent alloc] initWithMessage:[message advertiser]];
    _logo = [[CSNLogoComponent alloc] initWithMessage:[message logo]];
    _hero = [[CSNHeroComponent alloc] initWithMessage:[message hero]];
    _secondary = [[CSNSecondaryActionComponent alloc] initWithMessage:[message secondaryActionScreen]];

    NSMutableArray *actions = [[NSMutableArray alloc] initWithCapacity:[message actionsArray_Count]];
    for (id action in [message actionsArray]){
        CSNActionComponent *actionComp = [[CSNActionComponent alloc] initWithMessage:action];
        [actions addObject:actionComp];
        
    }
    _actions = actions;
    return self;
}

@end
