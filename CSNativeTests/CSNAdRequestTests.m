@import XCTest;
@import CSNative;

@interface CSNAdRequestTests : XCTestCase

@end

@implementation CSNAdRequestTests
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testShaWithNulls {
    CSNTransitStop *transitStop0 = [[CSNTransitStop alloc] initWithIDs:@"test_agency" routeID:@"test_route" stopID:@"test_stop"];
    CSNTransitStop *transitStop1 = [[CSNTransitStop alloc] initWithIDs:@"test_agency" routeID:NULL stopID:@"test_stop"];
    CSNTransitStop *transitStop2 = [[CSNTransitStop alloc] initWithIDs:NULL routeID:@"test_route" stopID:@"test_stop"];
    CSNTransitStop *transitStop3 = [[CSNTransitStop alloc] initWithIDs:@"test_agency" routeID:@"test_route" stopID:NULL];
    CSNTransitRoute *transitRoute0 = [[CSNTransitRoute alloc] initWithIDs:@"test_agency" routeID:@"test_route"];
    CSNTransitRoute *transitRoute1 = [[CSNTransitRoute alloc] initWithIDs:@"test_agency" routeID:NULL];
    CSNTransitRoute *transitRoute2 = [[CSNTransitRoute alloc] initWithIDs:NULL routeID:@"test_route"];
    CSNTransitAgency *transitAgency0 = [[CSNTransitAgency alloc] initWithIDs:@"test_agency"];
    CSNTransitAgency *transitAgency1 = [[CSNTransitAgency alloc] initWithIDs:NULL];
    CSNAdRequest *adRequest = [[CSNAdRequest alloc] init];
    [adRequest addStop:transitStop0];
    [adRequest addStop:transitStop1];
    [adRequest addStop:transitStop2];
    [adRequest addStop:transitStop3];
    [adRequest addRoute:transitRoute0];
    [adRequest addRoute:transitRoute1];
    [adRequest addRoute:transitRoute2];
    [adRequest addAgency:transitAgency0];
    [adRequest addAgency:transitAgency1];
    XCTAssertNoThrow([adRequest sha256]);
}

@end
