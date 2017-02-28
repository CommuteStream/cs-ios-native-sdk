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

- (void)testTitleInitWithMessage {
    CSNPTitleComponent *message = [[CSNPTitleComponent alloc] init];
    [message setComponentId:1];
    [message setTitle:@"test title"];
    CSNTitleComponent *component = [[CSNTitleComponent alloc] initWithMessage:message];
    XCTAssert([component componentID] == [message componentId]);
    XCTAssert([component title] == [message title]);
}

- (void)testIconInitWithMessage {
    UIImage *image = [UIImage imageWithContentsOfFile:@"cs.png"];
    NSData *imageData = UIImagePNGRepresentation(image);
    CSNPIconComponent *message = [[CSNPIconComponent alloc] init];
    [message setComponentId:1];
    [message setImage:imageData];
    CSNIconComponent *component = [[CSNIconComponent alloc] initWithMessage:message];
    XCTAssert([component componentID] == [message componentId]);
        XCTAssert([[component image] size].width == [image size].width);
    XCTAssert([[component image] size].height == [image size].height);
}

@end
