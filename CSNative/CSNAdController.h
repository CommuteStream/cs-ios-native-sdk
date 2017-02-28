@import UIKit;
#import "CSNClient.h"

#ifdef DEBUG
#import "CSNIconView.h"
#import "CSNTitleView.h"
#endif

@interface CSNAdController : NSObject

- (instancetype) init;

- (void) addStopAd:(UIView *)view agencyID:(NSString *)agencyID routeID:(NSString *)routeID stopID:(NSString *)stopID;
- (void) removeStopAd:(NSString *)agencyID routeID:(NSString *)routeID stopID:(NSString *)stopID;

- (void) refreshAds;


#ifdef DEBUG

- (instancetype) initWithClient:(id<CSNClient>)client;

- (NSArray<CSNIconView *> *) iconViews:(UIView *)parent;

- (NSArray<CSNTitleView *> *) titleViews:(UIView *)parent;

- (NSArray<UIView *> *) findViews:(UIView *)parent matcher:(bool (^)(UIView *))matcher;

- (void) findViews:(UIView *)parent views:(NSMutableArray<UIView *> *)views matcher:(bool (^)(UIView *))matcher;

- (void) buildViews:(CSNPAdResponse *)response;

#endif

@end
