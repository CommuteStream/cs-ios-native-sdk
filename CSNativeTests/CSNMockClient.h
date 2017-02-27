@import Foundation;
@import CSNative;

@interface CSNMockClient : NSObject <CSNClient>
@property (nonatomic, copy, nullable) void (^getAdBlock)(CSNPAdRequest *adRequest, (^()(CSNPAdResponse *adResponse)) success, (^()(NSError *error)) failure);

@end
