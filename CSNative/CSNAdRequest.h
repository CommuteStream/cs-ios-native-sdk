@import Foundation;
@import CoreLocation;
#import "CSNTransit.h"

@interface CSNAdRequest : NSObject
@property (readonly) NSOrderedSet* agencies;
@property (readonly) NSOrderedSet* routes;
@property (readonly) NSOrderedSet* stops;
- (instancetype) init;
- (NSData *) sha256;
- (void) addAgency:(CSNTransitAgency *)agency;
- (void) addRoute:(CSNTransitRoute *)route;
- (void) addStop:(CSNTransitStop *)stop;
- (void) removeUnknownMarkets:(NSSet<NSString*> *)markets;
- (NSUInteger) numOfTargets;
@end
