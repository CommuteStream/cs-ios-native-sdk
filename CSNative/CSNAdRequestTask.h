@import Foundation;
#import "CSNClient.h"
#import "CSNClientInfo.h"
#import "CSNAdRequest.h"
#import "CSNOptionalAd.h"

@interface CSNAdRequestTask : NSObject

- (instancetype) initWithClient:(id<CSNClient>)client
             clientInfo:(CSNClientInfo *)clientInfo
               settings:(CSNAdUnitSettings *)settings
               requests:(NSArray<CSNAdRequest *> *)requests
              completed:(void (^)(NSArray<CSNOptionalAd *> *))completed;
@end
