@import XCTest;
@import CSNative;

@interface CSNTitleView (Testing)
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@end

@interface CSNTitleViewTests : XCTestCase

@end

@implementation CSNTitleViewTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSetAd {
    CSNPTitleComponent *titleMessage = [[CSNPTitleComponent alloc] init];
    [titleMessage setComponentId:123];
    [titleMessage setTitle:@"test title"];
    CSNPNativeAd *message = [[CSNPNativeAd alloc] init];
    [message setTitle:titleMessage];
    CSNAd *ad = [[CSNAd alloc] initWithMessage:message];
    CSNTitleView *view = [[CSNTitleView alloc] init];
    [view setAd:ad];
    XCTAssert([view ad] == ad);
    XCTAssert([view componentID] == [[ad title] componentID]);
    NSLog(@"%@", [[view titleView] text]);
    XCTAssert([[[view titleView] text] isEqualToString:[[ad title] title]]);
}

@end
