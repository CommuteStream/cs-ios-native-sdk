@import UIKit;
#import "CSNHeadlineView.h"

@implementation CSNHeadlineView
@synthesize blockAction;

-(instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}


- (void) setAd:(CSNAd *)ad {
    _ad = ad;
    _componentID = [[ad headline] componentID];
    [self setText:[[ad headline] headline]];
    [self setNeedsDisplay];
}

- (void)addTapHandler:(nullable void(^)(void))callback {
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewAction:)];
    
    tapRecognizer.delegate = self;
    [self addGestureRecognizer:tapRecognizer];
    [self setUserInteractionEnabled:YES];
    
    [self setBlockAction:callback];
    
}

-(void) tapViewAction:(UIGestureRecognizer *)sender{
    
    [self invokeBlock:sender];
    
    
}

- (void) invokeBlock:(id)sender {
    [self blockAction]();
}

@end