//
//  CSNModalWindow.m
//  CSNative
//
//  Created by David Rogers on 3/21/17.
//  Copyright © 2017 CommuteStream. All rights reserved.
//

#import "CSNModalWindow.h"
#import "CSNStopTuple.h"
#import "CSNHeroView.h"
#import "CSNModalCardView.h"

@implementation CSNModalWindow {
    UIView *modalWindowBkg;
    CSNModalCardView *cardView;
    UIButton *closeModalWindow;
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame forAd:(CSNAd *)nativeAd {
    self = [super initWithFrame:frame];
    if (self)
    {
        
        modalWindowBkg = [[UIView alloc] initWithFrame:self.bounds];
        CGRect cardViewRect = CGRectMake(self.bounds.size.width/2.0, 500.0, self.bounds.size.width - 50.0, 325.0);
        cardView = [[CSNModalCardView alloc] initWithFrame:cardViewRect forAd:nativeAd];
        
        [modalWindowBkg setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6]];
        [modalWindowBkg setAlpha:0.0];
        [self addSubview:modalWindowBkg];
        [self addSubview:cardView];
        [modalWindowBkg setUserInteractionEnabled:YES];
        
        
        UIImage *buttonBkg = [UIImage imageNamed:@"close_interstitial_card.png"];
        CGRect closeInterstitialCardButtonRect = CGRectMake(self.bounds.size.width/2.0,(self.bounds.size.height - 130.0),80.0, 80.0);
        closeModalWindow = [UIButton buttonWithType:UIButtonTypeCustom];
        closeModalWindow.frame = closeInterstitialCardButtonRect;
        CGRect closeModalWindowFrame = [closeModalWindow frame];
        
        closeModalWindowFrame.origin.x = (closeModalWindow.frame.origin.x - closeModalWindow.frame.size.width/2);
        
        [closeModalWindow setFrame:closeModalWindowFrame];
        [closeModalWindow setAlpha:0.0];
        [closeModalWindow setBackgroundImage:buttonBkg forState:UIControlStateNormal];
        [closeModalWindow addTarget:self action:@selector(tapViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeModalWindow];
        
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             
                             [closeModalWindow setAlpha:1.0];
                             [modalWindowBkg setAlpha:1.0];
                             [cardView setAlpha:1.0];
                             [cardView setFrame:CGRectMake(cardView.frame.origin.x, 100.0, cardView.frame.size.width, cardView.frame.size.height)];
                             
                             
                         }
                         completion:^(BOOL finished){
                             
                             
                         }];
        
        
    }
    return self;
}

-(void) tapViewAction:(UIGestureRecognizer *)sender{
    
    
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         [closeModalWindow setAlpha:0.0];
                         [modalWindowBkg setAlpha:0.0];
                         [cardView setAlpha:0.0];
                         [cardView setFrame:CGRectMake(cardView.frame.origin.x, 500.0, cardView.frame.size.width, cardView.frame.size.height)];
                    
                         
                         
                     }
                     completion:^(BOOL finished){
                         [self setHidden:YES];
                         
                     }];
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
