@import XCTest;
@import UIKit;
@import CSNative;


@interface CSNAdsControllerTest : XCTestCase

@end

@implementation CSNAdsControllerTest

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
    CSNAdsController *controller = [[CSNAdsController alloc] init];
    NSArray<UIView *> *subviews = [controller findViews:view matcher:^bool(UIView *subview) {
        return subview == subview0;
    }];
    XCTAssert([subviews containsObject:subview0]);
    XCTAssert(![subviews containsObject:subview1]);
}

- (void)testComponentViews {
    UIView *view  = [[UIView alloc] init];
    UIView *subview0 = [[UIView alloc] init];
    CSNLogoView *logoview0 = [[CSNLogoView alloc] init];
    CSNLogoView *logoview1 = [[CSNLogoView alloc] init];
    CSNHeadlineView *headlineview0 = [[CSNHeadlineView alloc] init];
    [view addSubview:subview0];
    [view addSubview:logoview0];
    [view addSubview:headlineview0];
    [subview0 addSubview:logoview1];
    CSNAdsController *controller = [[CSNAdsController alloc] init];
    NSArray<UIView *> *subviews = [controller componentViews:view];
    XCTAssert([subviews containsObject:logoview0]);
    XCTAssert([subviews containsObject:logoview1]);
    XCTAssert(![subviews containsObject:subview0]);
}

- (void)testWithClient {
    XCTestExpectation *expectation = [self expectationWithDescription:@"failure"];
    CSNAdsController *controller = [[CSNAdsController alloc] initMocked];
    UIView *view = [[UIView alloc] init];
    CSNLogoView *logoView = [[CSNLogoView alloc] init];
    CSNHeadlineView *headlineView = [[CSNHeadlineView alloc] init];
    [view addSubview:logoView];
    [view addSubview:headlineView];
    [controller buildStopAd:view agencyID:@"test_agency" routeID:@"test_route" stopID:@"test_stop"];
    XCTAssert([logoView ad] == nil);
    XCTAssert([headlineView ad] == nil);
    CSNAdRequest *adRequest = [[CSNAdRequest alloc] init];
    [adRequest addStop:@"commutestream" routeID:@"test" stopID:@"test"];
    [controller fetchAds:adRequest completed:^{
        [controller buildStopAd:view agencyID:@"commutestream" routeID:@"test" stopID:@"test"];
        XCTAssert([logoView ad] != nil);
        XCTAssert([headlineView ad] != nil);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:1.0 handler:^(NSError * _Nullable error) {
        if(error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

@end
