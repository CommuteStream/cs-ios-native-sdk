#import "CSNClient.h"
#import "CSNHttpClient.h"
#import "CSNAdUnitSettings.h"
#import "CSNSDKVersion.h"

@implementation CSNHttpClient {
    NSString *_host;
    NSURLSession *_session;
}

- (instancetype) initWithHost:(NSString *)host requestTimeout:(uint64_t)requestTimeout responseTimeout:(uint64_t)responseTimeout {
    _host = host;
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    [config setTimeoutIntervalForRequest:requestTimeout];
    [config setTimeoutIntervalForResource:responseTimeout];
    [config setHTTPAdditionalHeaders:@{@"X-CS-Protocol": @"2"}];
    _session = [NSURLSession sessionWithConfiguration:config];
    return self;
}

- (void) getAds:(CSNPAdRequests *)adRequests success:(void (^)(CSNPAdResponses *))success failure:(void (^)(NSError *))failure {
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://%@/v2/ads", _host]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[adRequests data]];
    [request setValue:@"application/x-protobuf" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/x-protobuf" forHTTPHeaderField:@"Accepts"];
    NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error != NULL) {
            return failure(error);
        }
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if([httpResponse statusCode] != 200) {
            NSError *error = [[NSError alloc] initWithDomain:@"com.commutestream.native" code:[httpResponse statusCode] userInfo:@{@"request":request, @"response":httpResponse}];
            return failure(error);
        }
        if(![[[httpResponse allHeaderFields] valueForKey:@"Content-Type"] isEqualToString:@"application/x-protobuf"]) {
            NSError *error = [[NSError alloc] initWithDomain:@"com.commutestream.native" code:-1 userInfo:@{@"request":request, @"response":httpResponse}];
            return failure(error);
        }
        NSError *protobufError;
        CSNPAdResponses *adResponses = [CSNPAdResponses parseFromData:data error:&protobufError];
        if(protobufError) {
            return failure(protobufError);
        }
        return success(adResponses);
    }];
    [task resume];
}

- (void) getAd:(NSString *)adUrl
       success:(void (^)(CSNAd *))success
       failure:(void (^)(NSError *))failure
{
    NSURL *url = [[NSURL alloc] initWithString:adUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-protobuf" forHTTPHeaderField:@"Accepts"];
    NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error != NULL) {
            return failure(error);
        }
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if([httpResponse statusCode] != 200) {
            NSError *error = [[NSError alloc] initWithDomain:@"com.commutestream.native" code:[httpResponse statusCode] userInfo:@{@"request":request, @"response":httpResponse}];
            return failure(error);
        }
        if(![[[httpResponse allHeaderFields] valueForKey:@"Content-Type"] isEqualToString:@"application/x-protobuf"]) {
            NSError *error = [[NSError alloc] initWithDomain:@"com.commutestream.native" code:-1 userInfo:@{@"request":request, @"response":httpResponse}];
            return failure(error);
        }
        NSError *protobufError;
        CSNPAd *adMsg = [CSNPAd parseFromData:data error:&protobufError];
        if(protobufError) {
            return failure(protobufError);
        }
        CSNAd *ad = [[CSNAd alloc] initWithMessage:adMsg];
        return success(ad);
    }];
    [task resume];
}

- (void) sendAdReports:(CSNPAdReport *)adReports success:(void (^)(void))success failure:(void (^)(NSError *))failure {
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://%@/v2/reports", _host]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[adReports data]];
    [request setValue:@"application/x-protobuf" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/x-protobuf" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/x-protobuf" forHTTPHeaderField:@"Accepts"];
    NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error != NULL) {
            return failure(error);
        }
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if([httpResponse statusCode] != 204) {
            NSError *error = [[NSError alloc] initWithDomain:@"com.commutestream.native" code:[httpResponse statusCode] userInfo:@{@"request":request, @"response":httpResponse}];
            return failure(error);
        }
        if(![[[httpResponse allHeaderFields] valueForKey:@"Content-Type"] isEqualToString:@"application/x-protobuf"]) {
            NSError *error = [[NSError alloc] initWithDomain:@"com.commutestream.native" code:-1 userInfo:@{@"request":request, @"response":httpResponse}];
            return failure(error);
        }
        NSError *protobufError;
        [CSNPAdResponses parseFromData:data error:&protobufError];
        if(protobufError) {
            return failure(protobufError);
        }
        return success();
    }];
    [task resume];
}

- (void) getAdUnitSettings:(NSUUID *)adUnit success:(void (^)(CSNAdUnitSettings *))success failure:(void (^)(NSError *))failure {
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:[NSString stringWithFormat:@"https://%@/v2/ad_units/%@/settings", _host, adUnit]];
    NSMutableArray<NSURLQueryItem*> *queryItems = [[NSMutableArray alloc] initWithCapacity:8];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"sdk_version" value:CSN_SDK_VERSION]];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"os" value:[[UIDevice currentDevice] systemName]]];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"os_version" value:[[UIDevice currentDevice] systemVersion]]];
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"app_name"
                                                       value:[bundleInfo objectForKey:@"CFBundleDisplayName"]]];
    [queryItems addObject:[NSURLQueryItem queryItemWithName:@"app_version"
                                                       value:[bundleInfo objectForKey:@"CFBundleShortVersionString"]]];
    [urlComponents setQueryItems:queryItems];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[urlComponents URL]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-protobuf" forHTTPHeaderField:@"Accepts"];
    NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error != NULL) {
            return failure(error);
        }
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if([httpResponse statusCode] != 200) {
            NSError *error = [[NSError alloc] initWithDomain:@"com.commutestream.native" code:[httpResponse statusCode] userInfo:@{@"request":request, @"response":httpResponse}];
            return failure(error);
        }
        if(![[[httpResponse allHeaderFields] valueForKey:@"Content-Type"] isEqualToString:@"application/x-protobuf"]) {
            NSError *error = [[NSError alloc] initWithDomain:@"com.commutestream.native" code:-1 userInfo:@{@"request":request, @"response":httpResponse}];
            return failure(error);
        }
        NSError *protobufError;
        CSNPAdUnitSettings *settingsMsg = [CSNPAdUnitSettings parseFromData:data error:&protobufError];
        if(protobufError) {
            return failure(protobufError);
        }
        CSNAdUnitSettings *settings = [[CSNAdUnitSettings alloc] initWithMessage:settingsMsg];
        return success(settings);
    }];
    [task resume];
}

@end
