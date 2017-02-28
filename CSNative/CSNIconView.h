@import UIKit;

IB_DESIGNABLE
@interface CSNIconView : UIView
@property uint64_t requestID;
@property uint64_t adID;
@property uint64_t componentID;
- (void) setImage:(UIImage *)image;
@end
