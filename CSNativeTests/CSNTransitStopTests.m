@import XCTest;
@import CSNative;

@interface CSNTransitStopTests : XCTestCase

@end

@implementation CSNTransitStopTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testEquality {
    CSNTransitStop *transitStop0 = [[CSNTransitStop alloc] initWithIDs:@"test_agency" routeID:@"test_route" stopID:@"test_stop"];
    CSNTransitStop *transitStop1 = [[CSNTransitStop alloc] initWithIDs:@"test_agency" routeID:@"test_route" stopID:@"test_stop"];
    CSNTransitStop *transitStop2 = [[CSNTransitStop alloc] initWithIDs:@"test_agency0" routeID:@"test_route" stopID:@"test_stop"];
    XCTAssert([transitStop0 isEqual:transitStop1]);
    XCTAssert(![transitStop0 isEqual:transitStop2]);
}

- (void)testHash {
    CSNTransitStop *transitStop0 = [[CSNTransitStop alloc] initWithIDs:@"test_agency" routeID:@"test_route" stopID:@"test_stop"];
    CSNTransitStop *transitStop1 = [[CSNTransitStop alloc] initWithIDs:@"test_agency" routeID:@"test_route" stopID:@"test_stop"];
    CSNTransitStop *transitStop2 = [[CSNTransitStop alloc] initWithIDs:@"test_agency0" routeID:@"test_route" stopID:@"test_stop"];
    XCTAssert([transitStop0 hash] == [transitStop1 hash]);
    XCTAssert([transitStop0 hash] != [transitStop2 hash]);
}


@end
