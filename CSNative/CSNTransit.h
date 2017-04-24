@import Foundation;
#import "Csnmessages.pbobjc.h"

@interface CSNTransitAgency : NSObject <NSCopying>
@property (copy, nonnull) NSString *agencyID;
- (instancetype _Nonnull) initWithMessage:(CSNPTransitRoute * _Nonnull)stop;
- (instancetype _Nonnull) initWithIDs:(NSString * _Nonnull)agencyID;
@end

@interface CSNTransitRoute : NSObject <NSCopying>
@property (copy, nonnull) NSString *agencyID;
@property (copy, nonnull) NSString *routeID;
- (instancetype _Nonnull) initWithMessage:(CSNPTransitRoute * _Nonnull)stop;
- (instancetype _Nonnull) initWithIDs:(NSString * _Nonnull)agencyID routeID:(NSString * _Nonnull)routeID;
@end

@interface CSNTransitStop : NSObject <NSCopying>
@property (copy, nonnull) NSString *agencyID;
@property (copy, nonnull) NSString *routeID;
@property (copy, nonnull) NSString *stopID;
- (instancetype _Nonnull) initWithMessage:(CSNPTransitStop * _Nonnull)stop;
- (instancetype _Nonnull) initWithIDs:(NSString * _Nonnull)agencyID routeID:(NSString * _Nonnull)routeID stopID:(NSString * _Nonnull)stopID;
@end
