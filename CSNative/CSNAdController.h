@import Foundation;
#import "CSNClient.h"
#import "CSNAdView.h"

#ifdef DEBUG
#import "CSNIconView.h"
#endif

@interface CSNAdController : NSObject

- (instancetype) init;

- (void) addStopAd:(CSNAdView *)view agencyID:(NSString *)agencyID routeID:(NSString *)routeID stopID:(NSString *)stopID;
- (void) removeStopAd:(NSString *)agencyID routeID:(NSString *)routeID stopID:(NSString *)stopID;

- (void) refreshAds;


#ifdef DEBUG

- (instancetype) initWithClient:(id<CSNClient>)client;

- (NSArray<CSNIconView *> *) iconViews:(UIView *)parent;

- (NSArray<UIView *> *) findViews:(UIView *)parent matcher:(bool (^)(UIView *))matcher;

- (void) findViews:(UIView *)parent views:(NSMutableArray<UIView *> *)views matcher:(bool (^)(UIView *))matcher;

- (void) buildViews:(CSNPAdResponse *)response;

#endif

@end
