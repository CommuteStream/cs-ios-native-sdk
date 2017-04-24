@import XCTest;
@import CSNative;
@import OHHTTPStubs;

@interface CSNHttpClientTest : XCTestCase
@end

@implementation CSNHttpClientTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// Ensure a non-200 response is a failure
- (void)testGetStopAdsNon200 {
    XCTestExpectation *expectation = [self expectationWithDescription:@"failure"];
    CSNHttpClient *client = [[CSNHttpClient alloc] initWithHost:@"api.commutestream.com"];
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * request) {
        return [request.URL.host isEqualToString:@"api.commutestream.com"];
    } withStubResponse:^OHHTTPStubsResponse * (NSURLRequest * request) {
        NSData *data = [[NSData alloc] init];
        return [OHHTTPStubsResponse responseWithData:data statusCode:400 headers:NULL];
    }];
    CSNPAdRequests *adRequests = [[CSNPAdRequests alloc] init];
    [client getAds:adRequests success:^(CSNPAdResponses *adResponses) {
        XCTAssert(false);
    } failure:^(NSError *error) {
        XCTAssert(error != NULL);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:1.0 handler:^(NSError * _Nullable error) {
        if(error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

// Ensure a 200 response with an invalid content type is a failure
- (void)testGetStopdAds200InvalidContentType {
    XCTestExpectation *expectation = [self expectationWithDescription:@"failure"];
    CSNHttpClient *client = [[CSNHttpClient alloc] initWithHost:@"api.commutestream.com"];
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * request) {
        return [request.URL.host isEqualToString:@"api.commutestream.com"];
    } withStubResponse:^OHHTTPStubsResponse * (NSURLRequest * request) {
        NSData *data = [@"bogus" dataUsingEncoding:NSUTF8StringEncoding];
        return [OHHTTPStubsResponse responseWithData:data statusCode:200 headers:@{@"content-type":@"text/plain"}];
    }];
    CSNPAdRequests *adRequests = [[CSNPAdRequests alloc] init];
    [client getAds:adRequests success:^(CSNPAdResponses *adResponses) {
        XCTAssert(false);
    } failure:^(NSError *error) {
        XCTAssert(error != NULL);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:1.0 handler:^(NSError * _Nullable error) {
        if(error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

// Ensure a 200 response with an invalid body data is a failure
- (void) testGetStopdAds200InvalidBody {
    XCTestExpectation *expectation = [self expectationWithDescription:@"failure"];
    CSNHttpClient *client = [[CSNHttpClient alloc] initWithHost:@"api.commutestream.com"];
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * request) {
        return [request.URL.host isEqualToString:@"api.commutestream.com"];
    } withStubResponse:^OHHTTPStubsResponse * (NSURLRequest * request) {
        NSData *data = [@"bogus" dataUsingEncoding:NSUTF8StringEncoding];
        return [OHHTTPStubsResponse responseWithData:data statusCode:200 headers:@{@"content-type":@"application/x-protobuf"}];
    }];
    CSNPAdRequests *adRequests = [[CSNPAdRequests alloc] init];
    [client getAds:adRequests success:^(CSNPAdResponses *adResponses) {
        XCTAssert(false);
    } failure:^(NSError *error) {
        XCTAssert(error != NULL);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:1.0 handler:^(NSError * _Nullable error) {
        if(error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

// Ensure a slow request time is a failure
- (void) testGetStopAdsSlowRequest {
    XCTestExpectation *expectation = [self expectationWithDescription:@"failure"];
    CSNHttpClient *client = [[CSNHttpClient alloc] initWithHost:@"api.commutestream.com"];
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * request) {
        return [request.URL.host isEqualToString:@"api.commutestream.com"];
    } withStubResponse:^OHHTTPStubsResponse * (NSURLRequest * request) {
        NSData *data = [[[CSNPAdResponse alloc] init] data];
        return [[OHHTTPStubsResponse responseWithData:data statusCode:200 headers:@{@"content-type":@"application/x-protobuf"}] requestTime:1.2 responseTime:0.1];
    }];
    CSNPAdRequests *adRequests = [[CSNPAdRequests alloc] init];
    [client getAds:adRequests success:^(CSNPAdResponses *adResponses) {
        XCTAssert(false);
    } failure:^(NSError *error) {
        XCTAssert(error != NULL);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:1.5 handler:^(NSError * _Nullable error) {
        if(error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

// Ensure a slow response time is a failure
- (void) testGetStopAdsSlowResponse {
    XCTestExpectation *expectation = [self expectationWithDescription:@"failure"];
    CSNHttpClient *client = [[CSNHttpClient alloc] initWithHost:@"api.commutestream.com"];
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * request) {
        return [request.URL.host isEqualToString:@"api.commutestream.com"];
    } withStubResponse:^OHHTTPStubsResponse * (NSURLRequest * request) {
        NSData *data = [[[CSNPAdResponse alloc] init] data];
        return [[OHHTTPStubsResponse responseWithData:data statusCode:200 headers:@{@"content-type":@"application/x-protobuf"}] requestTime:0.1 responseTime:1.2];
    }];
    CSNPAdRequests *adRequests = [[CSNPAdRequests alloc] init];
    [client getAds:adRequests success:^(CSNPAdResponses *adResponses) {
        XCTAssert(false);
    } failure:^(NSError *error) {
        XCTAssert(error != NULL);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:1.5 handler:^(NSError * _Nullable error) {
        if(error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

// Ensure 200s with valid body data is in fact a success
- (void) testGetStopAdsSuccess {
    NSData *responseData = [[[CSNPAdResponse alloc] init] data];
    XCTestExpectation *expectation = [self expectationWithDescription:@"success"];
    CSNHttpClient *client = [[CSNHttpClient alloc] initWithHost:@"api.commutestream.com"];
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * request) {
        return [request.URL.host isEqualToString:@"api.commutestream.com"];
    } withStubResponse:^OHHTTPStubsResponse * (NSURLRequest * request) {
        return [OHHTTPStubsResponse responseWithData:responseData statusCode:200 headers:@{@"content-type":@"application/x-protobuf"}];
    }];
    CSNPAdRequests *adRequests = [[CSNPAdRequests alloc] init];
    [client getAds:adRequests success:^(CSNPAdResponses *responses) {
        XCTAssert(responses != NULL);
        [expectation fulfill];
    } failure:^(NSError *error) {
        NSLog(@"Unexpected Error: %@", error);
        XCTAssert(false);
    }];
    [self waitForExpectationsWithTimeout:1.0 handler:^(NSError * _Nullable error) {
        if(error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testSendAdReport {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    /*
    CSNHttpClient *client = [[CSNHttpClient alloc] initWithHost:@"api.commutestream.com"];
     */
    
}


@end
