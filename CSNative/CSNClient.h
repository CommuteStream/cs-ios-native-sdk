@import Foundation;
#import <CSNative/Csnmessages.pbobjc.h>

@protocol CSNClient
- (void) getAds:(CSNPAdRequest *)adRequest success:(void (^)(CSNPAdResponse *response))success failure:(void (^)(NSError *error))failure;
- (void) sendAdReport:(CSNPAdReport *)adReport success:(void (^)())success failure:(void (^)(NSError * error))failure;
@end
