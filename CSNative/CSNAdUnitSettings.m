@import Foundation;

#import "CSNAdUnitSettings.h"

@implementation CSNAdUnitSettings

- (instancetype) initWithMessage:(CSNPAdUnitSettings *)message {
    _enabled = [message enabled];
    _agencies = [NSSet setWithArray:[message agenciesArray]];
    return self;
}

@end
