@import UIKit;
#import "CSNClient.h"
#import "CSNOptionalAd.h"
#import "CSNAdRequest.h"

@interface CSNAdsController : NSObject

- (instancetype) initWithAdUnit:(NSData *)adUnit;

- (void) fetchAds:(NSArray<CSNAdRequest *> *)adRequests completed:(void (^)(NSArray<CSNOptionalAd *> *))completed;

- (void) buildView:(UIView  *)view ad:(CSNAd *)ad;

- (instancetype) initMocked;

- (instancetype) initWithClient:(id<CSNClient>)client adUnit:(NSData *)adUnit;

@end
