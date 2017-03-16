@import Foundation;
@import CoreLocation;

@interface CSNAdRequest : NSObject
@property (readonly) NSMutableSet* stops;
- (instancetype) init;
- (void) addStop:(NSString *)agencyID routeID:(NSString *)routeID stopID:(NSString *)stopID;
@end
