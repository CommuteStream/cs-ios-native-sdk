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

- (void) getAds:(CSNPAdRequest *)stopAdRequest success:(void (^)(CSNPAdResponse *))success failure:(void (^)(NSError *))failure {
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://%@/v2/stop_ads", _host]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPBody:[stopAdRequest data]];
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
        CSNPAdResponse *stopAdResponse = [CSNPAdResponse parseFromData:data error:&protobufError];
        if(protobufError) {
            return failure(protobufError);
        }
        return success(stopAdResponse);
    }];
    [task resume];
}

- (void) sendAdReport:(CSNPAdReport *)adReport success:(void (^)())success failure:(void (^)(NSError *))failure {
    NSError *error = [[NSError alloc] initWithDomain:@"com.commutestream.native" code:0 userInfo:NULL];
    failure(error);
}

@end
