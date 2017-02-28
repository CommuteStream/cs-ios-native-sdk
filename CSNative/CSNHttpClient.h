@import Foundation;
#import "CSNClient.h"

@interface CSNHttpClient : NSObject <CSNClient>

- (id) initWithHost:(NSString *)host;

@end
