//
//  CSNModalWindow.h
//  CSNative
//
//  Created by David Rogers on 3/21/17.
//  Copyright © 2017 CommuteStream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSNAd.h"
@interface CSNModalWindow : UIWindow<UIGestureRecognizerDelegate>


- (id) initWithFrame:(CGRect)frame forAd:(CSNAd *)nativeAd;

@end
