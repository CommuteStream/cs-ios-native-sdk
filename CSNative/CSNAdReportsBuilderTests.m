@import XCTest;
@import CSNative;

@interface CSNAdReportsBuilder (Test)
@property CSNPAdReports *adReports;
- (uint8_t) encodeVisibility:(double)visibility;
- (uint64_t) setSample:(uint64_t)current position:(uint64_t)position value:(uint8_t)value;
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

- (void) testEncodeVisibility {
    NSData *bogus = [[NSData alloc] init];
    CSNAdReportsBuilder *builder = [[CSNAdReportsBuilder alloc] initWithAdUnit:bogus deviceID:bogus ipAddress:bogus timeZone:@"UTC"];
    double increment = 1.0/15.0;
    double curVis = 0.0;
    for(uint8_t curVisEnc = 0; curVisEnc < 16; curVisEnc++) {
        XCTAssert([builder encodeVisibility:curVis] == curVisEnc);
        curVis += increment;
    }
    XCTAssert([builder encodeVisibility:0.0] == 0x00);
    XCTAssert([builder encodeVisibility:1.0] == 0x0F);
    XCTAssert([builder encodeVisibility:0.5] == 0x08);
}


- (void) testSetSample {
    NSData *bogus = [[NSData alloc] init];
    CSNAdReportsBuilder *builder = [[CSNAdReportsBuilder alloc] initWithAdUnit:bogus deviceID:bogus ipAddress:bogus timeZone:@"UTC"];
    uint64_t expect = 0xFEDCBA9876543210;
    uint64_t sample = 0;
    for(uint8_t value = 0; value < 16; value++) {
        sample = [builder setSample:sample position:value value:value];
    }
    XCTAssert(sample == expect);
}



- (void)testRecordInteraction {
    NSData *bogus = [[NSData alloc] init];
    CSNAdReportsBuilder *builder = [[CSNAdReportsBuilder alloc] initWithAdUnit:bogus deviceID:bogus ipAddress:bogus timeZone:@"UTC"];
    [builder recordVisibility:0 adID:0 componentID:0 viewVisibility:0.5 deviceVisibility:0.1];
    uint64_t expectViewVal = [builder setSample:0 position:0 value:[builder encodeVisibility:0.5]];
    uint64_t expectDevVal = [builder setSample:0 position:0 value:[builder encodeVisibility:0.1]];
    uint32_t ad_report_count = 0;
    uint32_t comp_report_count = 0;
    uint32_t visibility_count = 0;
    for(id adReport in [[builder adReports] adReportsArray]) {
        if([adReport requestId] == 0 && [adReport adId] == 0) {
            ad_report_count +=1;
            for(id compReport in [adReport componentsArray]) {
                if([compReport componentId] == 0) {
                    comp_report_count += 1;
                    visibility_count += [compReport visibilitySampleCount];
                    XCTAssert([[compReport viewVisibilitySamplesArray] valueAtIndex:0] == expectViewVal);
                    XCTAssert([[compReport deviceVisibilitySamplesArray] valueAtIndex:0] == expectDevVal);
                }
            }
        }
    }
    XCTAssert(ad_report_count == 1);
    XCTAssert(comp_report_count == 1);
    XCTAssert(visibility_count == 1);
    
    
    [builder recordVisibility:0 adID:0 componentID:0 viewVisibility:1.0 deviceVisibility:0.25];

    ad_report_count = 0;
    comp_report_count = 0;
    visibility_count = 0;
    for(id adReport in [[builder adReports] adReportsArray]) {
        if([adReport requestId] == 0 && [adReport adId] == 0) {
            ad_report_count +=1;
            for(id compReport in [adReport componentsArray]) {
                if([compReport componentId] == 0) {
                    comp_report_count += 1;
                    visibility_count += [compReport visibilitySampleCount];
                }
            }
        }
    }
    XCTAssert(ad_report_count == 1);
    XCTAssert(comp_report_count == 1);
    XCTAssert(visibility_count == 2);
}

- (void)testRecordVisibility {
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

- (void) testBuildReport {
    NSData *bogus = [[NSData alloc] init];
    CSNAdReportsBuilder *builder = [[CSNAdReportsBuilder alloc] initWithAdUnit:bogus deviceID:bogus ipAddress:bogus timeZone:@"UTC"];
    CSNPAdReports *report = [builder buildReport];
    XCTAssert([[report adUnit] isEqualToData:bogus]);
    XCTAssert([[report ipAddr] isEqualToData:bogus]);
    XCTAssert([[report timezone] isEqualToString:@"UTC"]);
    XCTAssert([[[report deviceId] deviceId] isEqualToData:bogus]);
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
