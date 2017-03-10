@import XCTest;
@import CSNative;

@interface CSNVisibilityMonitorTest : XCTestCase

@end

@implementation CSNVisibilityMonitorTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testVisibility {
    XCTestExpectation *expectation = [self expectationWithDescription:@"failure"];
    CSNIconView *view = [[CSNIconView alloc] init];
    CSNVisibilityMonitor *monitor = [[CSNVisibilityMonitor alloc] init];
    [monitor addView:view];
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, 1000000000);
    dispatch_after(when, dispatch_get_main_queue(), ^{
        //CSNReport *report = [monitor report];
        //CSNVisibilityReport *visReport = [report visibilityFor:view];
        //XCTAssert([visReport visibleTime] == 0);
        [expectation fulfill];
    });

    [self waitForExpectationsWithTimeout:1.0 handler:^(NSError * _Nullable error) {
        if(error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

@end
