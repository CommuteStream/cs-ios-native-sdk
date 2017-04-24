@import Foundation;
#import "CSNAd.h"

@interface CSNOptionalAd : NSObject
@property (readonly, nullable) CSNAd *ad;
- (instancetype _Nonnull) initWithAd:(CSNAd * _Nonnull)ad;
- (instancetype _Nonnull) initWithoutAd;
@end
