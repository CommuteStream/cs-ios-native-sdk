@import Foundation;
#import <CSNative/Csnmessages.pbobjc.h>

@protocol CSNClient
- (void) getAds:(CSNPAdRequests *)adRequest success:(void (^)(CSNPAdResponses *response))success failure:(void (^)(NSError *error))failure;
- (void) sendAdReports:(CSNPAdReports *)adReports success:(void (^)(void))success failure:(void (^)(NSError * error))failure;
@end
