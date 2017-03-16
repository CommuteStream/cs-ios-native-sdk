@import Foundation;
#import "CSNClient.h"
#import "CSNAd.h"
#import "CSNStopTuple.h"

@interface CSNMockClient : NSObject <CSNClient>
- (instancetype) init;
- (void) getAds:(CSNPAdRequest *)adRequest success:(void (^)(CSNPAdResponse *))success failure:(void (^)(NSError *))failure;
- (void) addStopAd:(CSNPNativeAd *)ad stop:(CSNPStop *)stop;
@end
