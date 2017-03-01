@import XCTest;
@import CSNative;

@interface CSNStopTupleTests : XCTestCase

@end

@implementation CSNStopTupleTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testEquality {
    CSNStopTuple *stopTuple0 = [[CSNStopTuple alloc] initWithIDs:@"test_agency" routeID:@"test_route" stopID:@"test_stop"];
    CSNStopTuple *stopTuple1 = [[CSNStopTuple alloc] initWithIDs:@"test_agency" routeID:@"test_route" stopID:@"test_stop"];
    CSNStopTuple *stopTuple2 = [[CSNStopTuple alloc] initWithIDs:@"test_agency0" routeID:@"test_route" stopID:@"test_stop"];
    XCTAssert([stopTuple0 isEqual:stopTuple1]);
    XCTAssert(![stopTuple0 isEqual:stopTuple2]);
}

- (void)testHash {
    CSNStopTuple *stopTuple0 = [[CSNStopTuple alloc] initWithIDs:@"test_agency" routeID:@"test_route" stopID:@"test_stop"];
    CSNStopTuple *stopTuple1 = [[CSNStopTuple alloc] initWithIDs:@"test_agency" routeID:@"test_route" stopID:@"test_stop"];
    CSNStopTuple *stopTuple2 = [[CSNStopTuple alloc] initWithIDs:@"test_agency0" routeID:@"test_route" stopID:@"test_stop"];
    XCTAssert([stopTuple0 hash] == [stopTuple1 hash]);
    XCTAssert([stopTuple0 hash] != [stopTuple2 hash]);
}


@end
