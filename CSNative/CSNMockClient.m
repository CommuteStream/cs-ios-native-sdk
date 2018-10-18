#import "CSNMockClient.h"
#import "CSNTransit.h"
#import "CSNAdRequest.h"
#import "CSNAdUnitSettings.h"

@interface CSNMockClient ()
@property NSSet<NSString *> *markets;
@property NSMutableDictionary *adResponses;
@property NSMutableDictionary<NSString *, CSNAd *> *ads;
@property CSNAdUnitSettings *settings;
@end

@implementation CSNMockClient

- (instancetype) init {
    _adResponses = [[NSMutableDictionary alloc] init];
    _ads = [[NSMutableDictionary alloc] init];
    NSString *imagePath = [[NSBundle bundleForClass:[CSNMockClient class]] pathForResource:@"cs" ofType:@"png"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    CSNTransitStop *transitStop0 = [[CSNTransitStop alloc] initWithIDs:@"commutestream" routeID:@"test" stopID:@"test"];
    CSNTransitStop *transitStop1 = [[CSNTransitStop alloc] initWithIDs:@"commutestream" routeID:@"test" stopID:@"1"];
    CSNTransitStop *transitStop2 = [[CSNTransitStop alloc] initWithIDs:@"commutestream" routeID:@"test" stopID:@"2"];
    [self addMockAd:transitStop0 adID:0 headlineStr:@"Test Ad" logoData:imageData];
    [self addMockAd:transitStop1 adID:1 headlineStr:@"Test Ad 1" logoData:imageData];
    [self addMockAd:transitStop2 adID:2 headlineStr:@"Test Ad 2" logoData:imageData];
    return self;
}

- (void) addMockAd:(CSNTransitStop *)stop adID:(uint64_t)adID headlineStr:(NSString *)headlineStr logoData:(NSData *)logoData {
    CSNPHeadlineComponent *headline = [[CSNPHeadlineComponent alloc] init];
    [headline setComponentId:adID*adID+1];
    [headline setHeadline:headlineStr];
    CSNPLogoComponent *logo = [[CSNPLogoComponent alloc] init];
    [logo setComponentId:adID*adID+2];
    [logo setImage:logoData];
    NSString *url = [NSString stringWithFormat:@"https://testad_url/ads/%lld/%d", adID, 0];
    CSNPAdReference *adRef = [[CSNPAdReference alloc] init];
    [adRef setAdId:adID];
    [adRef setVersionId:0];
    [adRef setURL:url];
    CSNPAd *testAd = [[CSNPAd alloc] init];
    [testAd setAdId:adID];
    [testAd setVersionId:0];
    [testAd setLogo:logo];
    [testAd setHeadline:headline];
    CSNAd *ad = [[CSNAd alloc] initWithMessage:testAd];
    ad.requestID = 0;
    [_ads setObject:ad forKey:url];
    CSNAdRequest *adRequest = [[CSNAdRequest alloc] init];
    [adRequest addStop:stop];
    NSData *sha = [adRequest sha256];
    CSNPAdResponse *adResponse = [[CSNPAdResponse alloc] init];
    NSMutableArray *adRefs = [[NSMutableArray alloc] initWithArray:@[adRef]];
    [adResponse setAdReferencesArray:adRefs];
    [adResponse setHashId:sha];
    [self setMockedResponse:adResponse];
}

- (void) getAds:(CSNPAdRequests *)adRequests
        success:(void (^)(CSNPAdResponses *))success
        failure:(void (^)(NSError *))failure
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


- (void) setMockedResponse:(CSNPAdResponse *)adResponse
{
    [_adResponses setObject:adResponse forKey:[adResponse hashId]];
}

- (void) getAd:(NSString *)url
       success:(void (^)(CSNAd *))success
       failure:(void (^)(NSError *))failure
{
    CSNAd *ad = [_ads objectForKey:url];
    success(ad);
}

- (void) sendAdReports:(CSNPAdReports *)adReport
               success:(void (^)(void))success
               failure:(void (^)(NSError *))failure
{
    success();
}

- (void)getAdUnitSettings:(NSUUID *)adUnit
                  success:(void (^)(CSNAdUnitSettings *))success
                  failure:(void (^)(NSError *))failure {
    success(_settings);
}

- (void) setMockedAdUnitSettings:(CSNAdUnitSettings *)settings
{
    _settings = settings;
}



@end
