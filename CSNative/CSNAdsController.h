@import UIKit;
#import "CSNClient.h"
#import "CSNAdRequest.h"

#ifdef DEBUG
#import "CSNIconView.h"
#import "CSNTitleView.h"
#endif

@interface CSNAdsController : NSObject

- (instancetype) init;

- (void) fetchAds:(CSNAdRequest *)request completed:(void (^)(void))completed;

- (void) buildStopAd:(UIView  *)view agencyID:(NSString *)agencyID routeID:(NSString *)routeID stopID:(NSString *)stopID;

- (instancetype) initMocked;

- (instancetype) initWithClient:(id<CSNClient>)client;

#ifdef DEBUG

- (NSArray<UIView *> *) componentViews:(UIView *)parent;

- (NSArray<UIView *> *) findViews:(UIView *)parent matcher:(bool (^)(UIView *))matcher;

- (void) findViews:(UIView *)parent views:(NSMutableArray<UIView *> *)views matcher:(bool (^)(UIView *))matcher;

- (void) cacheAds:(CSNPAdResponse *)response;

#endif

@end
