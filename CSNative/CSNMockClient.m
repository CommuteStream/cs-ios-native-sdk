#import "CSNMockClient.h"
#import "CSNTransit.h"
#import "CSNAdRequest.h"

@interface CSNMockClient ()
@property NSMutableDictionary *adResponses;
@end

@implementation CSNMockClient

- (instancetype) init {
    _adResponses = [[NSMutableDictionary alloc] init];
    CSNPHeadlineComponent *headline = [[CSNPHeadlineComponent alloc] init];
    [headline setComponentId:0];
    [headline setHeadline:@"Test Ad Title"];
    CSNPLogoComponent *logo = [[CSNPLogoComponent alloc] init];
    [logo setComponentId:1];
    NSString *imagePath = [[NSBundle bundleForClass:[CSNMockClient class]] pathForResource:@"cs" ofType:@"png"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    [logo setImage:imageData];
    CSNPNativeAd *testAd = [[CSNPNativeAd alloc] init];
    [testAd setAdId:99999999];
    [testAd setRequestId:0];
    [testAd setLogo:logo];
    [testAd setHeadline:headline];
    CSNTransitStop *transitStop = [[CSNTransitStop alloc] initWithIDs:@"commutestream" routeID:@"test" stopID:@"test"];
    CSNAdRequest *adRequest = [[CSNAdRequest alloc] init];
    [adRequest addStop:transitStop];
    NSData *sha = [adRequest sha256];
    CSNPAdResponse *adResponse = [[CSNPAdResponse alloc] init];
    NSMutableArray *ads = [[NSMutableArray alloc] initWithArray:@[testAd]];
    [adResponse setAdsArray:ads];
    [adResponse setHashId:sha];
    [_adResponses setObject:adResponse forKey:sha];
    return self;
}

- (void) getAds:(CSNPAdRequests *)adRequests success:(void (^)(CSNPAdResponses *))success failure:(void (^)(NSError *))failure
{
    CSNPAdResponses *responses = [[CSNPAdResponses alloc] init];
    [responses setAdResponsesArray:[[NSMutableArray alloc] init]];
    for(id adRequest in [adRequests adRequestsArray]) {
        NSData *requestSha = [adRequest hashId];
        CSNPAdResponse *adResponse = [_adResponses objectForKey:requestSha];
        if(adResponse != nil) {
            [[responses adResponsesArray] addObject:adResponse];
        }
    }
    success(responses);
}

- (void) setMockedResponse:(CSNPAdRequest *)adRequest response:(CSNPAdResponse *)adResponse {
    NSData *requestSha = [adRequest hashId];
    [_adResponses setObject:adResponse forKey:requestSha];
}

- (void) sendAdReports:(CSNPAdReports *)adReport success:(void (^)())success failure:(void (^)(NSError *))failure {
    success();
}

@end
