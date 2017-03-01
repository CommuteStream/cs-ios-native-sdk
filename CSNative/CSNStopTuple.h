@import Foundation;
#import "Csnmessages.pbobjc.h"

@interface CSNStopTuple : NSObject <NSCopying>
@property (copy, nonnull) NSString *agencyID;
@property (copy, nonnull) NSString *routeID;
@property (copy, nonnull) NSString *stopID;
- (instancetype _Nonnull) initWithMessage:(CSNPStop * _Nonnull)stop;
- (instancetype _Nonnull) initWithIDs:(NSString * _Nonnull)agencyID routeID:(NSString * _Nonnull)routeID stopID:(NSString * _Nonnull)stopID;
@end
