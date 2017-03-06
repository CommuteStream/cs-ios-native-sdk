@import XCTest;
@import CSNative;

@interface CSNIconViewTests : XCTestCase

@end

@implementation CSNIconViewTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSetAd {
    UIImage *image = [UIImage imageWithContentsOfFile:@"cs.png"];
    NSData *imageData = UIImagePNGRepresentation(image);
    CSNPIconComponent *iconMessage = [[CSNPIconComponent alloc] init];
    [iconMessage setComponentId:123];
    [iconMessage setImage:imageData];
    CSNPNativeAd *message = [[CSNPNativeAd alloc] init];
    [message setIcon:iconMessage];
    CSNAd *ad = [[CSNAd alloc] initWithMessage:message];
    CSNIconView *view = [[CSNIconView alloc] init];
    [view setAd:ad];
    XCTAssert([view ad] == ad);
    XCTAssert([view componentID] == [[ad icon] componentID]);
}

@end
