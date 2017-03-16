@import UIKit;
#import "CSNAd.h"
#import "CSNComponentView.h"

//IB_DESIGNABLE
@interface CSNTitleView : UILabel <CSNComponentView>
@property (readonly, nonnull) CSNAd *ad;
@property (readonly) uint64_t componentID;
- (void) setAd:(CSNAd * _Nonnull)ad;
@end
