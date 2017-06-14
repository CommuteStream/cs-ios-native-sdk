@import XCTest;
@import CSNative;

@interface CSNImpressionDetector (Test)
- (instancetype) initWithSampleSkew:(uint64_t)sampleSkew impressionTime:(uint64_t)impressionTime impressionDuration:(uint64_t)impressionDuration impressionVisibility:(double)impressionVisibility;
@end


@interface CSNImpressionDetectorTest : XCTestCase
@end

@implementation CSNImpressionDetectorTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testImpressionTime {
    CSNImpressionDetector *detector = [[CSNImpressionDetector alloc] initWithSampleSkew:1000 impressionTime:1 impressionDuration:30000 impressionVisibility:0.5];
    XCTAssert([detector recordVisibility:0 adID:0 componentID:0 viewVisibility:0.5 deviceVisibility:0.5] == false);
    usleep(2000);
    XCTAssert([detector recordVisibility:0 adID:0 componentID:0 viewVisibility:0.5 deviceVisibility:0.5] == true);
}


- (void)testImpressionVisibility {
    CSNImpressionDetector *detector = [[CSNImpressionDetector alloc] initWithSampleSkew:1000 impressionTime:1 impressionDuration:30000 impressionVisibility:0.3];
    XCTAssert([detector recordVisibility:0 adID:0 componentID:0 viewVisibility:0.2 deviceVisibility:0.1] == false);
    usleep(1500);
    XCTAssert([detector recordVisibility:0 adID:0 componentID:0 viewVisibility:0.2 deviceVisibility:0.1] == false);
    usleep(500);
    XCTAssert([detector recordVisibility:0 adID:0 componentID:0 viewVisibility:0.3 deviceVisibility:0.2] == false);
    usleep(2000);
    XCTAssert([detector recordVisibility:0 adID:0 componentID:0 viewVisibility:0.3 deviceVisibility:0.2] == true);
}

- (void)testImpressionDuration {
    CSNImpressionDetector *detector = [[CSNImpressionDetector alloc] initWithSampleSkew:1000 impressionTime:1 impressionDuration:10 impressionVisibility:0.5];
    XCTAssert([detector recordVisibility:0 adID:0 componentID:0 viewVisibility:0.5 deviceVisibility:0.1] == false);
    usleep(2000);
    XCTAssert([detector recordVisibility:0 adID:0 componentID:0 viewVisibility:0.5 deviceVisibility:0.1] == true);
    usleep(1500);
    XCTAssert([detector recordVisibility:0 adID:0 componentID:0 viewVisibility:0.3 deviceVisibility:0.2] == false);
    usleep(1500);
    XCTAssert([detector recordVisibility:0 adID:0 componentID:0 viewVisibility:0.5 deviceVisibility:0.2] == false);
    usleep(15000);
    XCTAssert([detector recordVisibility:0 adID:0 componentID:0 viewVisibility:0.5 deviceVisibility:0.2] == true);
    usleep(1500);
    XCTAssert([detector recordVisibility:0 adID:0 componentID:0 viewVisibility:0.5 deviceVisibility:0.2] == false);
}

@end
