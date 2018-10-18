@import Foundation;

#import "Csnmessages.pbobjc.h"
#import "CSNAd.h"
#import "CSNAdUnitSettings.h"

@protocol CSNClient
- (void) getAdUnitSettings:(NSUUID *)adUnit
             success:(void (^)(CSNAdUnitSettings *settings))success
             failure:(void (^)(NSError *error))failure;
- (void) getAds:(CSNPAdRequests *)adRequest success:(void (^)(CSNPAdResponses *response))success failure:(void (^)(NSError *error))failure;
- (void) getAd:(NSString *)adUrl success:(void (^)(CSNAd *ad))success failure:(void (^)(NSError *error))failure;
- (void) sendAdReports:(CSNPAdReports *)adReports success:(void (^)(void))success failure:(void (^)(NSError * error))failure;
@end
