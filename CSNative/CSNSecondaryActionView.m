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
        
        CGFloat yPosition = 5.0;
        
        if(![[[nativeAd transitTitle] title] isEqualToString:@""]){
            NSLog(@"Reached");
            NSLog(@"%@", [[nativeAd transitTitle] title]);
            transitHeaderLabel = [[CSNTransitTitleView alloc] initWithFrame:CGRectMake(9.0, yPosition + 5.0, self.frame.size.width - 50.0, 16.0)];
            [transitHeaderLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
            [transitHeaderLabel setAd:nativeAd];
            yPosition = transitHeaderLabel.frame.origin.y + transitHeaderLabel.frame.size.height;
        }
        
        if(![[[nativeAd transitSubtitle] subtitle] isEqualToString:@""]){
            transitSubheaderLabel = [[CSNTransitSubtitleView alloc] initWithFrame:CGRectMake(9.0, yPosition + 5.0, self.frame.size.width - 50.0, 14.0)];
            [transitSubheaderLabel setFont:[UIFont systemFontOfSize:12.0]];
            [transitSubheaderLabel setTextColor:[UIColor darkGrayColor]];
            [transitSubheaderLabel setAd:nativeAd];
            
            yPosition = transitSubheaderLabel.frame.origin.y + transitSubheaderLabel.frame.size.height;

        }
        
        CGFloat heroWidth = self.frame.size.width - 10;
        CGFloat heroHeight = heroWidth * 0.5225;
        
        heroImageView = [[CSNHeroView alloc] initWithFrame: CGRectMake(5.0, yPosition + 5.0, heroWidth , heroHeight)];
        [heroImageView setContentMode:UIViewContentModeScaleAspectFit];
        [heroImageView setBackgroundColor:[UIColor blackColor]];
        [heroImageView setAd:nativeAd];
        
        yPosition = heroImageView.frame.origin.y + heroImageView.frame.size.height;
        
        adInfoView = [[UIView alloc] initWithFrame:CGRectMake(5.0, yPosition, self.frame.size.width - 10.0, 50.0)];
        
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
        
        //CGFloat actionButtonsYPos = adInfoView.frame.origin.y + adInfoView.frame.size.height;
        
        CGFloat frameHeight = 0.0;
        NSUInteger actionIndex = 0;
        
        CGFloat buttonFontSize = 22.0;
        
        switch (actionArray.count) {
            case 1:
                buttonFontSize = 22.0;
                break;
                
            case 2:
                buttonFontSize = 19.0;
                break;
                
            case 3:
                buttonFontSize = 16.0;
                break;
                
            default:
                break;
        }
        
        
        for(CSNActionComponent *action in [nativeAd action]){
            
            //CGFloat actionButtonsYPos = (adInfoView.frame.origin.y + adInfoView.frame.size.height) + (actionIndex * 50) + (actionIndex * 5);
            CGFloat actionButtonsYPos = (adInfoView.frame.origin.y + adInfoView.frame.size.height) + 5.0;
            
            CGFloat actionButtonsWidth = (self.frame.size.width/actionArray.count);
            
            CSNActionView *actionButton = [[CSNActionView alloc] initWithFrame:CGRectMake(5.0 + (actionIndex * (actionButtonsWidth - (5.0/actionArray.count))), actionButtonsYPos, actionButtonsWidth - (5.0 + (5.0/actionArray.count)), 50.0)];
            
            [actionButton setAd:nativeAd atActionIndex:actionIndex];
            
            [actionButton setBackgroundColor:[UIColor colorWithRed:[item]/255.0 green:<#(CGFloat)#> blue:<#(CGFloat)#> alpha:<#(CGFloat)#>]]
            [actionButton setBackgroundColor: [[[nativeAd actions] objectAtIndex:actionIndex] backgroundColor]];
            [actionButton setTitleColor:[[[nativeAd actions] objectAtIndex:actionIndex] backgroundColor] forState:UIControlStateNormal];
            [[actionButton titleLabel] setFont: [UIFont systemFontOfSize:buttonFontSize]];
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

@end
