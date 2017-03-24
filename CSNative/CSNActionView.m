//
//  CSNActionView.m
//  CSNative
//
//  Created by David Rogers on 3/23/17.
//  Copyright © 2017 CommuteStream. All rights reserved.
//

#import "CSNActionView.h"

@implementation CSNActionView
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
    [self setNeedsDisplay];
}

- (void) setAd:(CSNAd *)ad atActionIndex:(NSUInteger)index {
    _ad = ad;
    _componentID = [[[ad actions] objectAtIndex:index] componentID];
    [self setTitle:[[[ad actions] objectAtIndex:index] title] forState:UIControlStateNormal];
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
