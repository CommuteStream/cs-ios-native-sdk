@import Foundation;

#import "Csnmessages.pbobjc.h"

@interface CSNAdUnitSettings : NSObject
@property bool enabled;
@property NSSet<NSString *> *agencies;
- (instancetype) initWithMessage:(CSNPAdUnitSettings *)settings;
@end

