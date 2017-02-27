#import <Foundation/Foundation.h>
#import "CSNClient.h"
#import "CSNAdView.h"

@interface CSNAdBuilder : NSObject

- (id) initWithClient:(id<CSNClient>)client;

- (void) addStopNativeAd:(CSNAdView *)view agencyID:(NSString *)agencyID routeID:(NSString *)routeID stopID:(NSString *)stopID;

- (void) build;

@end
