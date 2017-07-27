#import "CSNSecondaryActionView.h"
#import <CSNative/CSNative.h>

@implementation CSNSecondaryActionView{
    CSNHeroView *heroImageView;
    UILabel *secondaryTitle;
    UILabel *secondarySubtitle;
    
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


- (id) initWithFrame:(CGRect)aRect forAd:(CSNAd *)nativeAd withReportsBuilder:(CSNAdReportsBuilder *)reportBuilder {
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
        
        if(![[[nativeAd secondary] title] isEqualToString:@""]){
            secondaryTitle = [[UILabel alloc] initWithFrame:CGRectMake(9.0, yPosition + 4.0, self.frame.size.width - 18.0, 16.0)];
            [secondaryTitle setFont:[UIFont boldSystemFontOfSize:14.0]];
            [secondaryTitle setText:[[nativeAd secondary] title]];
            yPosition = secondaryTitle.frame.origin.y + secondaryTitle.frame.size.height;
        }
        
        if(![[[nativeAd secondary] subtitle] isEqualToString:@""]){
            secondarySubtitle = [[UILabel alloc] initWithFrame:CGRectMake(9.0, yPosition + 2.0, self.frame.size.width - 18.0, 14.0)];
            [secondarySubtitle setFont:[UIFont systemFontOfSize:12.0]];
            
            [secondarySubtitle setTextColor:[UIColor darkGrayColor]];
            [secondarySubtitle setNumberOfLines:0];
            [secondarySubtitle setText:[[nativeAd secondary] subtitle]];
            [secondarySubtitle sizeToFit];
            yPosition = secondarySubtitle.frame.origin.y + secondarySubtitle.frame.size.height;
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
        
        
        bodyLabel = [[CSNBodyView alloc] initWithFrame:CGRectMake(44.0, 21.0, adInfoView.frame.size.width - 50.0, 14.0)];
        //NSString *bodyString = nativeAd.body.body;
        [bodyLabel setFont:[UIFont systemFontOfSize:10.0]];
        [bodyLabel setLineBreakMode:NSLineBreakByWordWrapping];
        
        bodyLabel.numberOfLines = 0;
        //CGSize maxSize = CGSizeMake(bodyLabel.frame.size.width, 40.0);
        //CGSize expectedLabelSize = [bodyString sizeWithFont:bodyLabel.font constrainedToSize:maxSize lineBreakMode:bodyLabel.lineBreakMode];
        
        
        //CGSize expectedLabelSize = [bodyString bou]
        //CGRect newFrame = bodyLabel.frame;
        //newFrame.size.height = expectedLabelSize.height;
        //bodyLabel.frame = newFrame;
        
        [bodyLabel setTextColor:[UIColor darkGrayColor]];
        [bodyLabel setAd:nativeAd];
        [bodyLabel sizeToFit];
        
        yPosition = bodyLabel.frame.origin.y + bodyLabel.frame.size.height;
        advertiserLabel = [[CSNAdvertiserView alloc] initWithFrame:CGRectMake(44.0, yPosition, self.frame.size.width - 50.0, 14.0)];
        [advertiserLabel setFont:[UIFont systemFontOfSize:9.0]];
        [advertiserLabel setTextColor:[UIColor lightGrayColor]];
        [advertiserLabel setAd:nativeAd];
        CGRect adInfoFrame = adInfoView.frame;
        adInfoFrame.size.height = advertiserLabel.frame.origin.y + advertiserLabel.frame.size.height + 2.0;
        
        adInfoView.frame = adInfoFrame;
        
        
        
        [self addSubview:secondaryTitle];
        [self addSubview:secondarySubtitle];
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
        NSUInteger actionCount = [[nativeAd actions] count];
        
        switch ([[nativeAd actions] count]) {
            case 1:
                buttonFontSize = 22.0;
                break;
                
            case 2:
                buttonFontSize = 19.0;
                break;
                
            case 3:
                buttonFontSize = 14.0;
                break;
                
            default:
                break;
        }
        
        for(CSNActionComponent *action in [nativeAd actions]){
            
            //CGFloat actionButtonsYPos = (adInfoView.frame.origin.y + adInfoView.frame.size.height) + (actionIndex * 50) + (actionIndex * 5);
            CGFloat actionButtonsYPos = (adInfoView.frame.origin.y + adInfoView.frame.size.height) + 5.0;
            
            CGFloat actionButtonsWidth = (self.frame.size.width/actionCount);
            
            CSNActionView *actionButton = [[CSNActionView alloc] initWithFrame:CGRectMake(5.0 + (actionIndex * (actionButtonsWidth - (5.0/actionCount))), actionButtonsYPos, actionButtonsWidth - (5.0 + (5.0/actionCount)), 50.0)];
            
            [actionButton setAd:nativeAd atActionIndex:actionIndex];
            
            [actionButton setBackgroundColor:[[action colors] background]];
            [actionButton setTitleColor:[[action colors] foreground] forState:UIControlStateNormal];
            [[actionButton titleLabel] setFont: [UIFont systemFontOfSize:buttonFontSize]];
            [[actionButton titleLabel] setLineBreakMode:NSLineBreakByWordWrapping];
            [[actionButton titleLabel] setTextAlignment:NSTextAlignmentCenter];
            [actionButton addTapHandler:^{
                [reportBuilder recordInteraction:[nativeAd requestID] adID:[nativeAd adID] versionID:[nativeAd versionID] componentID:[action componentID] interactionKind:CSNPComponentInteractionKind_Tap];
                
                NSString *urlString = [[[nativeAd actions] objectAtIndex:actionIndex] url];
                NSURL *url = [NSURL URLWithString:urlString];
                
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

        [self setAd:nativeAd];        
    }
    
    
    return self;
    
}

- (void) setAd:(CSNAd *)ad {
    _ad = ad;
    _componentID = [[ad secondary] componentID];
}

@end
