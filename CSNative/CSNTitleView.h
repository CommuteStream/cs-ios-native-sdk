@import UIKit;
#import "CSNAd.h"
#import "CSNComponentView.h"

IB_DESIGNABLE
@interface CSNTitleView : UIView <CSNComponentView>
@property (readonly, nonnull) CSNAd *ad;
@property (readonly) uint64_t componentID;
@end
