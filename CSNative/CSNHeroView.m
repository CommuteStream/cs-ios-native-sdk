#import "CSNHeroView.h"
@import WebKit;

@implementation CSNHeroView

-(instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

- (void)setAd:(CSNAd *)ad {
    _ad = ad;
    _componentID = [[ad hero] componentID];
    if ([[ad hero] html] != nil) {
        WKWebView *heroWebView = [[WKWebView alloc] init];
        [heroWebView loadHTMLString:[[ad hero] html] baseURL:nil];
        [heroWebView setFrame: self.bounds];
        [heroWebView setUserInteractionEnabled:[[ad hero] interactive]];
        [self addSubview:heroWebView];
    } else {
        UIImageView *heroImageView = [[UIImageView alloc] initWithImage:[[ad hero] image]];
        [heroImageView setFrame: self.bounds];
        [self addSubview:heroImageView];
    }
    [self setNeedsDisplay];
}
                                                                                                               
@end
