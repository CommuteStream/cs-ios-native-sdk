#import "CSNClient.h"
#import "CSNHttpClient.h"

@implementation CSNHttpClient {
    NSString *_host;
    NSURLSession *_session;
}

- (instancetype) initWithHost:(NSString *)host {
    _host = host;
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    [config setTimeoutIntervalForRequest:1];
    [config setTimeoutIntervalForResource:1];
    _session = [NSURLSession sessionWithConfiguration:config];
    return self;
}

- (void) getAds:(CSNPAdRequests *)adRequests success:(void (^)(CSNPAdResponses *))success failure:(void (^)(NSError *))failure {
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://%@/v2/native_ads", _host]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPBody:[adRequests data]];
    [[request allHTTPHeaderFields] setValue:@"v1" forKey:@"X-CS-Protocol"];
    [[request allHTTPHeaderFields] setValue:@"application/x-protobuf" forKey:@"Content-Type"];
    [[request allHTTPHeaderFields] setValue:@"application/x-protobuf" forKey:@"Accepts"];
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

- (void) sendAdReports:(CSNPAdReport *)adReports success:(void (^)())success failure:(void (^)(NSError *))failure {
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://%@/v2/native_reports", _host]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPBody:[adReports data]];
    [[request allHTTPHeaderFields] setValue:@"v1" forKey:@"X-CS-Protocol"];
    [[request allHTTPHeaderFields] setValue:@"application/x-protobuf" forKey:@"Content-Type"];
    [[request allHTTPHeaderFields] setValue:@"application/x-protobuf" forKey:@"Accepts"];
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
        CSNPAdResponses *adResponses = [CSNPAdResponses parseFromData:data error:&protobufError];
        if(protobufError) {
            return failure(protobufError);
        }
        return success(adResponses);
    }];
    [task resume];
}

@end
