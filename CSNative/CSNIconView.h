@import UIKit;
#import "CSNComponentView.h"
#import "CSNAd.h"

IB_DESIGNABLE
@interface CSNIconView : UIView <CSNComponentView>
@property (readonly, nonnull) CSNAd *ad;
@property (readonly) uint64_t componentID;
- (_Nonnull instancetype) initWithAd:(CSNAd * _Nonnull)ad;
@end
