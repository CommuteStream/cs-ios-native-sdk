#import "CSNMockClient.h"

@interface CSNMockClient ()
@property NSMutableDictionary *ads;
@property NSMutableDictionary *stopAds;
@end

@implementation CSNMockClient

- (instancetype) init {
    _ads = [[NSMutableDictionary alloc] init];
    _stopAds = [[NSMutableDictionary alloc] init];
    //CSNPTitleComponent *title = [[CSNPTitleComponent alloc] init];
    //[title setComponentId:0];
    //[title setTitle:@"Test Ad Title"];
    //CSNPLogoComponent *logo = [[CSNPLogoComponent alloc] init];
    //[logo setComponentId:1];
    //NSString *imagePath = [[NSBundle bundleForClass:[CSNMockClient class]] pathForResource:@"cs" ofType:@"png"];
    //NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    //[logo setImage:imageData];
    //CSNPNativeAd *testAd = [[CSNPNativeAd alloc] init];
    //[testAd setAdId:99999999];
    //[testAd setRequestId:0];
    //[testAd setLogo:logo];
    //[testAd setTitle:title];
    //CSNPStop *stop = [[CSNPStop alloc] init];
    //[stop setAgencyId:@"commutestream"];
    //[stop setRouteId:@"test"];
    //[stop setStopId:@"test"];
    //[self addStopAd:testAd stop:stop];
    return self;
}

- (void) getAds:(CSNPAdRequest *)adRequest success:(void (^)(CSNPAdResponse *))success failure:(void (^)(NSError *))failure
{
    CSNPAdResponse *response = [[CSNPAdResponse alloc] init];
    for(id stop in [adRequest stopsArray]) {
        CSNStopTuple *stopTuple = [[CSNStopTuple alloc] initWithMessage:stop];
        NSNumber *adId = [_stopAds objectForKey:stopTuple];
        if(adId == nil) {
            continue;
        }
        CSNPNativeAd *ad = [_ads objectForKey:adId];
        if(ad == nil) {
            continue;
        }
        CSNPStopAd *stopAd = [[CSNPStopAd alloc] init];
        [stopAd setStopTuple:stop];
        [stopAd setAdId:[ad adId]];
        [[response stopAdsArray] addObject:stopAd];
        [[response ads] setObject:ad forKey:[ad adId]];
    }
    success(response);
}

- (void) addStopAd:(CSNPNativeAd *)ad stop:(CSNPStop *)stop {
    CSNStopTuple *stopTuple = [[CSNStopTuple alloc] initWithMessage:stop];
    //NSLog(@"adding %@ key %lld and stop %@ to internal dict", ad, [ad adId], stopTuple);
    NSNumber *adID = [NSNumber numberWithUnsignedLongLong:[ad adId]];
    [_stopAds setObject:adID forKey:stopTuple];
    [_ads setObject:ad forKey:adID];
}

- (void) sendAdReport:(CSNPAdReport *)adReport success:(void (^)())success failure:(void (^)(NSError *))failure {
    success();
}

@end
