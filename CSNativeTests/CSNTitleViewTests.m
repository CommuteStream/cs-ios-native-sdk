@import XCTest;
@import CSNative;

@interface CSNHeadlineView (Testing)
@end

@interface CSNHeadlineViewTests : XCTestCase

@end

@implementation CSNHeadlineViewTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSetAd {
    CSNPHeadlineComponent *headlineMessage = [[CSNPHeadlineComponent alloc] init];
    [headlineMessage setComponentId:123];
    [headlineMessage setHeadline:@"test headline"];
    CSNPNativeAd *message = [[CSNPNativeAd alloc] init];
    [message setHeadline:headlineMessage];
    CSNAd *ad = [[CSNAd alloc] initWithMessage:message];
    CSNHeadlineView *view = [[CSNHeadlineView alloc] init];
    [view setAd:ad];
    XCTAssert([view ad] == ad);
    XCTAssert([view componentID] == [[ad headline] componentID]);
    NSLog(@"%@", [view text]);
    XCTAssert([[view text] isEqualToString:[[ad headline] headline]]);
}

@end
