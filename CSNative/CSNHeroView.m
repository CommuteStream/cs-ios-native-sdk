#import "CSNHeroView.h"

@implementation CSNHeroView
@synthesize blockAction;

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
    UIImageView *heroImageView = [[UIImageView alloc] initWithImage:[[ad hero] image]];
    [heroImageView setFrame: self.bounds];
    [self addSubview:heroImageView];
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
    NSLog(@"tapped it yo");
    
}

- (void) invokeBlock:(id)sender {
    [self blockAction]();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
