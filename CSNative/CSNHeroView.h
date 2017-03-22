//
//  CSNHeroView.h
//  CSNative
//
//  Created by David Rogers on 3/21/17.
//  Copyright © 2017 CommuteStream. All rights reserved.
//

@import UIKit;
#import "CSNComponentView.h"
#import "CSNAd.h"

//IB_DESIGNABLE
@interface CSNHeroView : UIView <CSNComponentView, UIGestureRecognizerDelegate>
@property (readonly, nonnull) CSNAd *ad;
@property (readonly) uint64_t componentID;
@property BOOL interactable;
- (void) setAd:(CSNAd * _Nonnull)ad;
@end
