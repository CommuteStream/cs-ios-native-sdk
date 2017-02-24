#import <Foundation/Foundation.h>
#import <CSNative/Csnmessages.pbobjc.h>

@protocol CSNClient
- (void) getStopAds:(CSNStopAdRequest *)stopAdRequest success:(void (^)(CSNStopAdResponse *response))success failure:(void (^)(NSError *error))failure;
- (void) sendAdReport:(CSNAdReport *)adReport success:(void (^)())success failure:(void (^)(NSError * error))failure;
@end
