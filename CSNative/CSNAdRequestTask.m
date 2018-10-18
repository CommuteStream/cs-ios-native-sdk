@import Foundation;

#import "CSNAdRequestTask.h"
#import "CSNLocationManager.h"
#import "CSNClient.h"
#import "CSNClientInfo.h"
#import "CSNSDKVersion.h"
#import "Csnmessages.pbobjc.h"

@interface CSNAdRequestTask ()
@property id<CSNClient> client;
@property CSNClientInfo *clientInfo;
@property CSNAdUnitSettings *settings;
@property NSArray<CSNAdRequest *> *requests;
@property NSMutableDictionary<NSNumber *, CSNPAdReference *> *references;
@property NSMutableArray<CSNOptionalAd*> *responses;
@property void (^completed)(NSArray<CSNOptionalAd *> *);
@end

@implementation CSNAdRequestTask : NSObject

- (instancetype) initWithClient:(id<CSNClient>)client
                     clientInfo:(CSNClientInfo*)clientInfo
                       settings:(CSNAdUnitSettings *)settings
                       requests:(NSArray<CSNAdRequest *> *)requests
                      completed:(void (^)(NSArray<CSNOptionalAd *> *))completed
{
    _client = client;
    _clientInfo = clientInfo;
    _settings = settings;
    _requests = requests;
    _completed = completed;
    _references = [[NSMutableDictionary alloc] init];
    _responses = [[NSMutableArray alloc] init];
    for(CSNAdRequest * request __unused in _requests) {
        [_responses addObject:[[CSNOptionalAd alloc] initWithoutAd]];
    }
    [self sendRequests];
    return self;
}

- (void) sendRequests {
    CSNPAdRequests *requestsMessage = [self buildRequestsMessage:_requests];
    if([requestsMessage adRequestsArray_Count] == 0) {
        _completed(_responses);
        return;
    }
    [_client getAds:requestsMessage success:^(CSNPAdResponses *responsesMessage) {
        [self createReferences:responsesMessage];
        [self enqueueAdRequests];
        
    } failure:^(NSError *error) {
        // on failure, log
        NSLog(@"CSNAdRequestTask sendRequests failed, cause %@", error);
        _completed(_responses);
    }];
}

- (CSNPAdRequests *) buildRequestsMessage:(NSArray<CSNAdRequest *> *)adRequests {
    [[CSNLocationManager sharedLocationManager] getLocations];
    NSMutableDictionary *uniqueAdRequests = [[NSMutableDictionary alloc] initWithCapacity:[adRequests count]];
    CSNPAdRequests *adRequestsMsg = [[CSNPAdRequests alloc] init];
    [adRequestsMsg setIpAddressesArray:[NSMutableArray arrayWithArray:_clientInfo.ipAddresses]];
    [adRequestsMsg setAdUnit:[_clientInfo getAdUnitData]];
    [adRequestsMsg setDeviceId:_clientInfo.deviceID];
    [adRequestsMsg setTimezone:_clientInfo.timeZone];
    [adRequestsMsg setSdkVersion:CSN_SDK_VERSION];
    for(CSNAdRequest *adRequest in adRequests) {
        [adRequest removeUnknownMarkets:_settings.agencies];
        if([adRequest numOfTargets] > 0) {
            NSData *requestSha = [adRequest sha256];
            CSNPAdRequest *adRequestMsg = [uniqueAdRequests objectForKey:requestSha];
            if(adRequestMsg) {
                [adRequestMsg setNumOfAds:[adRequestMsg numOfAds] + 1];
            } else {
                adRequestMsg = [[CSNPAdRequest alloc] init];
                [adRequestMsg setHashId:requestSha];
                [adRequestMsg setNumOfAds:1];
                for(id agency in [[adRequest agencies] array]) {
                    CSNPTransitAgency *transitAgency = [[CSNPTransitAgency alloc] init];
                    [transitAgency setAgencyId:[agency agencyID]];
                    [[adRequestMsg agenciesArray] addObject:transitAgency];
                }
                for(id route in [[adRequest routes] array]) {
                    CSNPTransitRoute *transitRoute = [[CSNPTransitRoute alloc] init];
                    [transitRoute setAgencyId:[route agencyID]];
                    [transitRoute setRouteId:[route routeID]];
                    [[adRequestMsg routesArray] addObject:transitRoute];
                }
                for(id stop in [[adRequest stops] array]) {
                    CSNPTransitStop *transitStop = [[CSNPTransitStop alloc] init];
                    [transitStop setAgencyId:[stop agencyID]];
                    [transitStop setRouteId:[stop routeID]];
                    [transitStop setStopId:[stop stopID]];
                    [[adRequestMsg stopsArray] addObject:transitStop];
                }
                [uniqueAdRequests setObject:adRequestMsg forKey:requestSha];
                [[adRequestsMsg adRequestsArray] addObject:adRequestMsg];
            }
        }
    }
    return adRequestsMsg;
}

- (void) createReferences:(CSNPAdResponses *)adResponses {
    NSMutableDictionary *hashedIndices = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *hashedResponses = [[NSMutableDictionary alloc] init];
    for(id adResponse in [adResponses adResponsesArray]) {
        [hashedResponses setObject:adResponse forKey:[adResponse hashId]];
        [hashedIndices setObject:[NSNumber numberWithUnsignedInteger:0] forKey:[adResponse hashId]];
    }
    unsigned int curRequestId = 0;
    for(id adRequest in _requests) {
        NSData *hash = [adRequest sha256];
        NSNumber *index = [hashedIndices objectForKey:hash];
        NSUInteger indexval = [index unsignedIntegerValue];
        CSNPAdResponse *response = [hashedResponses objectForKey:hash];
        if(index && response && indexval < [response adReferencesArray_Count]) {
            CSNPAdReference *adReference = [[response adReferencesArray] objectAtIndex:indexval];
            NSNumber *curRequestIdNum = [NSNumber numberWithUnsignedInteger:curRequestId];
            [_references setObject:adReference forKey:curRequestIdNum];
            [hashedIndices setObject:[NSNumber numberWithUnsignedInteger:indexval+1] forKey:hash];
        }
        curRequestId++;
    }
}

- (void) enqueueAdRequests {
    dispatch_group_t group = dispatch_group_create();
    CSNAdRequestTask *task = self;

    id<CSNClient> client = _client;
    for(NSNumber *requestID in [_references allKeys]) {
        CSNPAdReference *adRef = [_references objectForKey:requestID];
        dispatch_group_enter(group);
        [client getAd:[adRef URL] success:^(CSNAd *ad) {
            CSNOptionalAd *optAd = [[CSNOptionalAd alloc] initWithAd:ad];
            CSNAdRequest *request = [_requests objectAtIndex:[requestID unsignedIntegerValue]];
            [task setResponse:[requestID unsignedIntegerValue] ad:optAd];
            if(request.completed != nil) {
                request.completed(optAd);
            }
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            // on failure, log
            NSLog(@"CSNAdRequestTask requesting ad failed, cause %@", error);
            CSNOptionalAd *optAd = [[CSNOptionalAd alloc] initWithoutAd];
            CSNAdRequest *request = [_requests objectAtIndex:[requestID unsignedIntegerValue]];
            [task setResponse:[requestID unsignedIntegerValue] ad:optAd];
            if(request.completed != nil) {
                request.completed(optAd);
            }
            dispatch_group_leave(group);
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [task done];
    });
}

- (void)setResponse:(NSUInteger)index ad:(CSNOptionalAd*)ad {
    @synchronized (self) {
        [_responses replaceObjectAtIndex:index withObject:ad];
        
    }
}

- (void) done {
    @synchronized (self) {
        _completed(_responses);
    }
}


@end
