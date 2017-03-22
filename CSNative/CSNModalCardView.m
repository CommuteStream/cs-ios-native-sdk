//
//  CSNModalCardView.m
//  CSNative
//
//  Created by David Rogers on 3/22/17.
//  Copyright © 2017 CommuteStream. All rights reserved.
//

#import "CSNModalCardView.h"

@implementation CSNModalCardView{
    CSNHeroView *heroImageView;
    CSNTransitTitleView *transitHeaderLabel;
    CSNTransitSubtitleView *transitSubheaderLabel;

    CSNTitleView *adTitleLabel;
    CSNDescriptionView *adDescriptionLabel;
    CSNWebURLView *adUrlLabel;
    CSNIconView *adIconImage;
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
        
        adIconImage = [[CSNIconView alloc] initWithFrame:CGRectMake(7.0, 7.0, 30.0, 30.0)];
        [adIconImage setContentMode:UIViewContentModeScaleAspectFit];
        [adIconImage setAd:nativeAd];
        
        
        
        adTitleLabel = [[CSNTitleView alloc] initWithFrame:CGRectMake(44.0, 7.0, adInfoView.frame.size.width - 50.0, 14.0)];
        [adTitleLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
        [adTitleLabel setAd:nativeAd];
        
        
        adDescriptionLabel = [[CSNDescriptionView alloc] initWithFrame:CGRectMake(44.0, 21.0, self.frame.size.width - 50.0, 14.0)];
        [adDescriptionLabel setFont:[UIFont systemFontOfSize:10.0]];
        [adDescriptionLabel setTextColor:[UIColor darkGrayColor]];
        [adDescriptionLabel setAd:nativeAd];
        
        
        adUrlLabel = [[CSNWebURLView alloc] initWithFrame:CGRectMake(44.0, 33.0, self.frame.size.width - 50.0, 14.0)];
        [adUrlLabel setFont:[UIFont systemFontOfSize:8.0]];
        [adUrlLabel setTextColor:[UIColor lightGrayColor]];
        [adUrlLabel setAd:nativeAd];
        
        
        
        
        [self addSubview:transitHeaderLabel];
        [self addSubview:transitSubheaderLabel];
        [self addSubview:heroImageView];
        
        [adInfoView addSubview:adIconImage];
        [adInfoView addSubview:adTitleLabel];
        [adInfoView addSubview:adDescriptionLabel];
        [adInfoView addSubview:adUrlLabel];
        [self addSubview:adInfoView];
        
        //NSMutableArray *actionArray = [stopObject objectForKey:@"actions"];
        
        //CGFloat actionButtonsYPos = adInfoView.frame.origin.y + adInfoView.frame.size.height;
        
        CGFloat frameHeight = 0.0;
        

        frameHeight = adInfoView.frame.origin.y + adInfoView.frame.size.height + 5;
            

        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, frameHeight);
        
        
    }
    
    return self;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
