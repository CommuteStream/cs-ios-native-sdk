@import XCTest;
@import UIKit;
@import CSNative;


@interface CSNAdControllerTest : XCTestCase

@end

@implementation CSNAdControllerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFindViews {
    UIView *view  = [[UIView alloc] init];
    UIView *subview0 = [[UIView alloc] init];
    UIView *subview1 = [[UIView alloc] init];
    [view addSubview:subview0];
    [view addSubview:subview1];
    CSNAdController *controller = [[CSNAdController alloc] init];
    NSArray<UIView *> *subviews = [controller findViews:view matcher:^bool(UIView *subview) {
        return subview == subview0;
    }];
    XCTAssert([subviews containsObject:subview0]);
    XCTAssert(![subviews containsObject:subview1]);
}

- (void)testComponentViews {
    UIView *view  = [[UIView alloc] init];
    UIView *subview0 = [[UIView alloc] init];
    CSNIconView *iconview0 = [[CSNIconView alloc] init];
    CSNIconView *iconview1 = [[CSNIconView alloc] init];
    CSNTitleView *titleview0 = [[CSNTitleView alloc] init];
    [view addSubview:subview0];
    [view addSubview:iconview0];
    [view addSubview:titleview0];
    [subview0 addSubview:iconview1];
    CSNAdController *controller = [[CSNAdController alloc] init];
    NSArray<UIView *> *subviews = [controller componentViews:view];
    XCTAssert([subviews containsObject:iconview0]);
    XCTAssert([subviews containsObject:iconview1]);
    XCTAssert(![subviews containsObject:subview0]);
}

- (void)testWithClient {
    CSNAdController *controller = [[CSNAdController alloc] initMocked];
    UIView *view = [[UIView alloc] init];
    CSNIconView *iconView = [[CSNIconView alloc] init];
    CSNTitleView *titleView = [[CSNTitleView alloc] init];
    [view addSubview:iconView];
    [view addSubview:titleView];
    [controller addStopAd:view agencyID:@"test_agency" routeID:@"test_route" stopID:@"test_stop"];
    [controller refreshAds];
    XCTAssert([iconView ad] != nil);
    XCTAssert([titleView ad] != nil);
}

@end
