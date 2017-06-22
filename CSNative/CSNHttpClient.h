@import Foundation;
#import "CSNClient.h"

@interface CSNHttpClient : NSObject <CSNClient>

- (id) initWithHost:(NSString *)host requestTimeout:(uint64_t)requestTimeout responseTimeout:(uint64_t)responseTimeout;

@end
