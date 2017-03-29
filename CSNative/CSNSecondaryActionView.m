//
//  CSNSecondaryActionView.m
//  CSNative
//
//  Created by David Rogers on 3/27/17.
//  Copyright © 2017 CommuteStream. All rights reserved.
//

#import "CSNSecondaryActionView.h"

@implementation CSNSecondaryActionView{
    CSNHeroView *heroImageView;
    CSNTransitTitleView *transitHeaderLabel;
    CSNTransitSubtitleView *transitSubheaderLabel;
    
    CSNHeadlineView *headlineLabel;
    CSNBodyView *bodyLabel;
    CSNAdvertiserView *advertiserLabel;
    CSNLogoView *adLogoImage;
    UIView *adInfoView;
    
}
@synthesize blockAction;

-(id)init
{
    self = [super init];
    if(self){
        
        
        
    }
    return self;
}

-  (id)initWithFrame:(CGRect)aRect
{
    self = [super initWithFrame:aRect];
    
    if (self)
    {
        
    }
    
    return self;
}


- (id) initWithFrame:(CGRect)aRect forAd:(CSNAd *)nativeAd {
    self = [super initWithFrame:aRect];
    
    if (self)
    {
        
        [self setFrame:aRect];
        [self setBackgroundColor:[UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1.0]];
        [self setAlpha:0.0];
        
        CGRect tempFrame = [self frame];
        tempFrame.origin.x = (self.frame.origin.x - self.frame.size.width/2);
        [self setFrame:tempFrame];
        
        transitHeaderLabel = [[CSNTransitTitleView alloc] initWithFrame:CGRectMake(9.0, 12.0, self.frame.size.width - 50.0, 16.0)];
        [transitHeaderLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        [transitHeaderLabel setAd:nativeAd];
        
        transitSubheaderLabel = [[CSNTransitSubtitleView alloc] initWithFrame:CGRectMake(9.0, 30.0, self.frame.size.width - 50.0, 14.0)];
        [transitSubheaderLabel setFont:[UIFont systemFontOfSize:12.0]];
        [transitSubheaderLabel setTextColor:[UIColor darkGrayColor]];
        [transitSubheaderLabel setAd:nativeAd];
        
        CGFloat heroImageYPos = transitSubheaderLabel.frame.origin.y + transitSubheaderLabel.frame.size.height + 8.0;
        CGFloat heroWidth = self.frame.size.width - 10;
        CGFloat heroHeight = heroWidth * 0.5225;
        
        heroImageView = [[CSNHeroView alloc] initWithFrame: CGRectMake(5.0,heroImageYPos, heroWidth , heroHeight)];
        [heroImageView setContentMode:UIViewContentModeScaleAspectFit];
        [heroImageView setBackgroundColor:[UIColor blackColor]];
        [heroImageView setAd:nativeAd];
        
        CGFloat adInfoYPos = heroImageView.frame.origin.y + heroImageView.frame.size.height;
        
        adInfoView = [[UIView alloc] initWithFrame:CGRectMake(5.0, adInfoYPos, self.frame.size.width - 10.0, 50.0)];
        
        [adInfoView setBackgroundColor:[UIColor whiteColor]];
        
        adLogoImage = [[CSNLogoView alloc] initWithFrame:CGRectMake(7.0, 7.0, 30.0, 30.0)];
        [adLogoImage setContentMode:UIViewContentModeScaleAspectFit];
        [adLogoImage setAd:nativeAd];
        
        
        
        headlineLabel = [[CSNHeadlineView alloc] initWithFrame:CGRectMake(44.0, 7.0, adInfoView.frame.size.width - 50.0, 14.0)];
        [headlineLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
        [headlineLabel setAd:nativeAd];
        
        
        bodyLabel = [[CSNBodyView alloc] initWithFrame:CGRectMake(44.0, 21.0, self.frame.size.width - 50.0, 14.0)];
        [bodyLabel setFont:[UIFont systemFontOfSize:10.0]];
        [bodyLabel setTextColor:[UIColor darkGrayColor]];
        [bodyLabel setAd:nativeAd];
        
        
        advertiserLabel = [[CSNAdvertiserView alloc] initWithFrame:CGRectMake(44.0, 33.0, self.frame.size.width - 50.0, 14.0)];
        [advertiserLabel setFont:[UIFont systemFontOfSize:8.0]];
        [advertiserLabel setTextColor:[UIColor lightGrayColor]];
        [advertiserLabel setAd:nativeAd];
        
        
        
        
        [self addSubview:transitHeaderLabel];
        [self addSubview:transitSubheaderLabel];
        [self addSubview:heroImageView];
        
        [adInfoView addSubview:adLogoImage];
        [adInfoView addSubview:headlineLabel];
        [adInfoView addSubview:bodyLabel];
        [adInfoView addSubview:advertiserLabel];
        [self addSubview:adInfoView];
        
        NSMutableArray *actionArray = [[NSMutableArray alloc] initWithArray:[nativeAd actions]];
        
        //CGFloat actionButtonsYPos = adInfoView.frame.origin.y + adInfoView.frame.size.height;
        
        CGFloat frameHeight = 0.0;
        NSUInteger actionIndex = 0;
        for(NSDictionary *item in actionArray){
            NSLog(@"Item in Array = %@", item);
            
            CGFloat actionButtonsYPos = (adInfoView.frame.origin.y + adInfoView.frame.size.height) + (actionIndex * 50) + (actionIndex * 5);
            
            CSNActionView *actionButton = [[CSNActionView alloc] initWithFrame:CGRectMake(5.0, actionButtonsYPos + 5.0, self.frame.size.width - 10.0, 50.0)];
            
            [actionButton setAd:nativeAd atActionIndex:actionIndex];
            
            //UILabel *buttonTitle = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 6.0, actionButton.frame.size.width - 10.0, 26)];
            //[buttonTitle setTextAlignment:NSTextAlignmentCenter];
            //buttonTitle.text = [item objectForKey:@"title"];
            //[buttonTitle setTextColor:[UIColor whiteColor]];
            //buttonTitle.font = [UIFont systemFontOfSize:23];
            //[actionButton addSubview:buttonTitle];
            
            //UILabel *buttonSubtitle = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 28.0, actionButton.frame.size.width - 10.0, 20)];
            //[buttonSubtitle setTextAlignment:NSTextAlignmentCenter];
            //buttonSubtitle.text = [item objectForKey:@"subtitle"];
            //[buttonSubtitle setTextColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6]];
            //buttonSubtitle.font = [UIFont systemFontOfSize:9];
            //[actionButton addSubview:buttonSubtitle];
            
            [actionButton setBackgroundColor: [[[nativeAd actions] objectAtIndex:actionIndex] color]];
            [actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [[actionButton titleLabel] setFont: [UIFont systemFontOfSize:22.0]];
            [actionButton addTapHandler:^{
                
                NSString *urlString = [[[nativeAd actions] objectAtIndex:actionIndex] url];
                NSURL *url = [NSURL URLWithString:urlString];
                //NSLog(@"tapped it %@", [[[nativeAd actions] objectAtIndex:actionIndex] url]);
                
                if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:NULL];
                }else{
                    // Fallback on earlier versions
                    [[UIApplication sharedApplication] openURL:url];
                }
                
                
                
                
            }];
            
            [self addSubview:actionButton];
            
            frameHeight = actionButton.frame.origin.y + actionButton.frame.size.height + 5;
            actionIndex++;
        }
        
        
        //frameHeight = adInfoView.frame.origin.y + adInfoView.frame.size.height + 5;
        
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, frameHeight);
        
        
    }
    
    
    return self;
    
}

- (void) setAd:(CSNAd *)ad {
    _ad = ad;
    _componentID = [[ad transitTitle] componentID];
}

- (void)addTapHandler:(nullable void(^)(void))callback {
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewAction:)];
    
    tapRecognizer.delegate = self;
    [self setUserInteractionEnabled:YES];
    
    [self setBlockAction:callback];
    
}

-(void) tapViewAction:(UIGestureRecognizer *)sender{
    
    //[self invokeBlock:sender];
    
    
}

- (void) invokeBlock:(id)sender {
    //[self blockAction]();
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
