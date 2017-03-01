@import Foundation;
#import "CSNClient.h"

@interface CSNMockClient : NSObject <CSNClient>
- (void) getAds:(CSNPAdRequest *)adRequest success:(void (^)(CSNPAdResponse *))success failure:(void (^)(NSError *))failure;
@end
