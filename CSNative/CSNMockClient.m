#import "CSNMockClient.h"

@implementation CSNMockClient
- (void) getAds:(CSNPAdRequest *)adRequest success:(void (^)(CSNPAdResponse *))success failure:(void (^)(NSError *))failure
{
    CSNPAdResponse *response = [[CSNPAdResponse alloc] init];
    CSNPNativeAd *testAd = [[CSNPNativeAd alloc] init];
    [testAd setAdId:0];
    [testAd setRequestId:0];
    CSNPTitleComponent *title = [[CSNPTitleComponent alloc] init];
    [title setComponentId:0];
    [title setTitle:@"Test Ad Title"];
    CSNPIconComponent *icon = [[CSNPIconComponent alloc] init];
    [icon setComponentId:1];
    [icon setImage:[NSData dataWithContentsOfFile:@"cs.png"]];
    [testAd setTitle:title];
    [testAd setIcon:icon];
    for(id stop in [adRequest stopsArray]) {
        CSNPStopAd *stopAd = [[CSNPStopAd alloc] init];
        [stopAd setStopTuple:stop];
        [stopAd setAdId:[testAd adId]];
        [[response stopAdsArray] addObject:stopAd];
    }
    success(response);
}

- (void) sendAdReport:(CSNPAdReport *)adReport success:(void (^)())success failure:(void (^)(NSError *))failure {
    success();
}

@end
