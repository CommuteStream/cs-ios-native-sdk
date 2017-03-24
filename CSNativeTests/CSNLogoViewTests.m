@import XCTest;
@import CSNative;

@interface CSNLogoView (Testing)
@property (weak, nonatomic) IBOutlet UIImageView *logoView;
@end

@interface CSNLogoViewTests : XCTestCase

@end

@implementation CSNLogoViewTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSetAd {
    UIImage *image = [UIImage imageWithContentsOfFile:@"cs.png"];
    NSData *imageData = UIImagePNGRepresentation(image);
    CSNPLogoComponent *logoMessage = [[CSNPLogoComponent alloc] init];
    [logoMessage setComponentId:123];
    [logoMessage setImage:imageData];
    CSNPNativeAd *message = [[CSNPNativeAd alloc] init];
    [message setLogo:logoMessage];
    CSNAd *ad = [[CSNAd alloc] initWithMessage:message];
    CSNLogoView *view = [[CSNLogoView alloc] init];
    [view setAd:ad];
    XCTAssert([view ad] == ad);
    XCTAssert([view componentID] == [[ad logo] componentID]);
    XCTAssert([view image] == [[ad logo] image]);
}

@end
