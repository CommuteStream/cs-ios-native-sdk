//
//  CSNSecondaryActionView.h
//  CSNative
//
//  Created by David Rogers on 3/27/17.
//  Copyright © 2017 CommuteStream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CSNative/CSNative.h>
#import "CSNAd.h"

@interface CSNSecondaryActionView : UIView<CSNComponentView, UIGestureRecognizerDelegate>
@property (readonly, nonnull) CSNAd *ad;
@property (readonly) uint64_t componentID;
@property BOOL interactable;
- (void) setAd:(CSNAd * _Nonnull)ad;

- (nullable id) initWithFrame:(CGRect)aRect forAd:(CSNAd * _Nonnull)nativeAd;

@end
