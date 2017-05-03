@import XCTest;
@import CSNative;

@interface CSNAdReportsBuilder (Test)
@property CSNPAdReports *adReports;
@end

@interface CSNAdReportsBuilderTests : XCTestCase

@end

@implementation CSNAdReportsBuilderTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreateAdReports {
    NSData *adUnit = [[NSData alloc] init];
    NSData *deviceId = [[NSData alloc] init];
    NSData *ipAddr = [[NSData alloc] init];
    NSString *timeZone = @"UTC";
    CSNAdReportsBuilder *builder = [[CSNAdReportsBuilder alloc] initWithAdUnit:adUnit deviceID:deviceId ipAddress:ipAddr timeZone:timeZone];
    XCTAssert([[builder adReports] adUnit] == adUnit);
    XCTAssert([[[builder adReports] deviceId] deviceIdType] == CSNPDeviceID_Type_Idfa);
    XCTAssert([[[builder adReports] deviceId] deviceId] == deviceId);
    XCTAssert([[builder adReports] ipAddr] == ipAddr);
    XCTAssert([[builder adReports] timezone] == timeZone);
    
}


- (void)testReportInteraction {
    NSData *bogus = [[NSData alloc] init];
    CSNAdReportsBuilder *builder = [[CSNAdReportsBuilder alloc] initWithAdUnit:bogus deviceID:bogus ipAddress:bogus timeZone:@"UTC"];
    [builder recordInteraction:0 adID:0 componentID:0 interactionKind:0];
    uint32_t ad_report_count = 0;
    uint32_t comp_report_count = 0;
    uint32_t comp_interactions_count = 0;
    for(id adReport in [[builder adReports] adReportsArray]) {
        if([adReport requestId] == 0 && [adReport adId] == 0) {
            ad_report_count +=1;
            for(id compReport in [adReport componentsArray]) {
                if([compReport componentId] == 0) {
                    comp_report_count += 1;
                    comp_interactions_count += [compReport interactionsArray_Count];
                }
            }
        }
    }
    XCTAssert(ad_report_count == 1);
    XCTAssert(comp_report_count == 1);
    XCTAssert(comp_interactions_count == 1);
    
    [builder recordInteraction:0 adID:0 componentID:0 interactionKind:0];
    ad_report_count = 0;
    comp_report_count = 0;
    comp_interactions_count = 0;
    for(id adReport in [[builder adReports] adReportsArray]) {
        if([adReport requestId] == 0 && [adReport adId] == 0) {
            ad_report_count +=1;
            for(id compReport in [adReport componentsArray]) {
                if([compReport componentId] == 0) {
                    comp_report_count += 1;
                    comp_interactions_count += [compReport interactionsArray_Count];
                }
            }
        }
    }
    XCTAssert(ad_report_count == 1);
    XCTAssert(comp_report_count == 1);
    XCTAssert(comp_interactions_count == 2);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
