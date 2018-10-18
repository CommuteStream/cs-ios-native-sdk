@import XCTest;
@import CSNative;

@interface CSNHeroView (Testing)
@property (weak, nonatomic) IBOutlet UIImageView *heroView;
@end

@interface CSNHeroViewTests : XCTestCase

@end

@implementation CSNHeroViewTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSetAd {
    UIImage *image = [UIImage imageWithContentsOfFile:@"cs.png"];
    NSData *imageData = UIImagePNGRepresentation(image);
    CSNPHeroComponent *heroMessage = [[CSNPHeroComponent alloc] init];
    [heroMessage setComponentId:123];
    [heroMessage setKind: CSNPHeroKind_Image];
    [heroMessage setBlob:imageData];
    CSNPAd *message = [[CSNPAd alloc] init];
    [message setHero:heroMessage];
    CSNAd *ad = [[CSNAd alloc] initWithMessage:message];
    CSNHeroView *view = [[CSNHeroView alloc] init];
    [view setAd:ad];
    XCTAssert([view ad] == ad);
    XCTAssert([view componentID] == [[ad hero] componentID]);
    UIImageView *testImageView = [[view subviews] firstObject];
    XCTAssert(testImageView != nil);
    XCTAssert([testImageView image] == [[ad hero] image]);
}

@end
