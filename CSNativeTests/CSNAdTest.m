@import XCTest;
@import CSNative;

@interface CSNAdTest : XCTestCase

@end

@implementation CSNAdTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testHeadlineInitWithMessage {
    CSNPHeadlineComponent *message = [[CSNPHeadlineComponent alloc] init];
    [message setComponentId:1];
    [message setHeadline:@"test headline"];
    CSNPHeadlineComponent *component = [[CSNPHeadlineComponent alloc] initWithMessage:message];
    XCTAssert([component componentID] == [message componentId]);
    XCTAssert([component headline] == [message headline]);
}

- (void)testLogoInitWithMessage {
    UIImage *image = [UIImage imageWithContentsOfFile:@"cs.png"];
    NSData *imageData = UIImagePNGRepresentation(image);
    CSNPLogoComponent *message = [[CSNPLogoComponent alloc] init];
    [message setComponentId:1];
    [message setImage:imageData];
    CSNLogoComponent *component = [[CSNLogoComponent alloc] initWithMessage:message];
    XCTAssert([component componentID] == [message componentId]);
        XCTAssert([[component image] size].width == [image size].width);
    XCTAssert([[component image] size].height == [image size].height);
}

@end
