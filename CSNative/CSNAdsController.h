@import UIKit;
#import "CSNClient.h"
#import "CSNOptionalAd.h"
#import "CSNAdRequest.h"

@interface CSNAdsController : NSObject

- (instancetype) initWithAdUnit:(NSString *)adUnit;

- (void) fetchAds:(NSArray<CSNAdRequest *> *)adRequests completed:(void (^)(NSArray<CSNOptionalAd *> *))completed;

- (void) buildView:(UIView  *)view ad:(CSNAd *)ad parentTouch:(bool)parentTouch;

- (instancetype) initMocked;

- (instancetype) initWithClient:(id<CSNClient>)client adUnit:(NSData *)adUnit;

- (void) applicationDidEnterBackground;

@end
