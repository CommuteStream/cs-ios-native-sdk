@import Foundation;
#import "CSNClient.h"

@interface CSNMockClient : NSObject <CSNClient>
- (instancetype) init;
- (void) getAds:(CSNPAdRequests *)adRequests success:(void (^)(CSNPAdResponses *))success failure:(void (^)(NSError *))failure;
- (void) setMockedResponse:(CSNPAdResponse *)response;
- (void) setMarketsResponse:(NSSet<NSString*> *)markets;
@end
