#import "CSNModalWindow.h"
#import "CSNTransit.h"
#import "CSNHeroView.h"
#import "CSNSecondaryActionView.h"

@implementation CSNModalWindow {
    UIView *modalWindowBkg;
    CSNSecondaryActionView *cardView;
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

- (id) initWithFrame:(CGRect)frame forAd:(CSNAd *)nativeAd withReportsBuilder:(CSNAdReportsBuilder *)reportsBuilder {
    self = [super initWithFrame:frame];
    if (self)
    {
        
        modalWindowBkg = [[UIView alloc] initWithFrame:self.bounds];
        CGRect cardViewRect = CGRectMake(self.bounds.size.width/2.0, 500.0, self.bounds.size.width - 50.0, 325.0);
        cardView = [[CSNSecondaryActionView alloc] initWithFrame:cardViewRect forAd:nativeAd withReportsBuilder:reportsBuilder];
        
        [modalWindowBkg setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6]];
        [modalWindowBkg setAlpha:0.0];
        [self addSubview:modalWindowBkg];
        [self addSubview:cardView];
        [modalWindowBkg setUserInteractionEnabled:YES];
        
        NSString *imagePath = [[NSBundle bundleForClass:[CSNModalWindow class]] pathForResource:@"close_interstitial_card" ofType:@"png"];
        NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
        UIImage *buttonBkg = [[UIImage alloc] initWithData:imageData];
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
        
        CGFloat cardTop = (closeModalWindowFrame.origin.y/2) - (cardView.frame.size.height/2);
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             
                             [closeModalWindow setAlpha:1.0];
                             [modalWindowBkg setAlpha:1.0];
                             [cardView setAlpha:1.0];
                             [cardView setFrame:CGRectMake(cardView.frame.origin.x, cardTop, cardView.frame.size.width, cardView.frame.size.height)];
                             
                             
                         }
                         completion:^(BOOL finished){
                             
                             
                         }];
        
        
    }
    return self;
}

- (id<CSNComponentView>)getSecondaryActionView {
    return cardView;
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
                         // avoid tracking this view for impressions by hidding it and setting its size to 0
                         [cardView setFrame:CGRectMake(0,0,0,0)];
                         [cardView setHidden:YES];
                         [self removeFromSuperview];
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
