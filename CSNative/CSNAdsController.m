#import "CSNAdsController.h"
#import "CSNClient.h"
#import "CSNHttpClient.h"
#import "CSNMockClient.h"
#import "CSNLogoView.h"
#import "CSNModalWindow.h"
#import "CSNVisibilityMonitor.h"
#import "CSNAdReportsBuilder.h"
#import "Csnmessages.pbobjc.h"

#include <ifaddrs.h>
#include <arpa/inet.h>



@interface CSNAdsController ()
@property id<CSNClient> client;
@property CSNVisibilityMonitor *visMonitor;
@property NSData *adUnit;
@property CSNPDeviceID *deviceID;
@property NSArray<NSData *> *ipAddresses;
@property NSString *timeZone;
@property CSNAdReportsBuilder *reportsBuilder;
@property NSTimer *reportsTimer;
- (void) openModal:(CSNAd *)ad componentID:(uint64_t)componentID interactionKind:(int32_t)interactionKind;
@end

@interface CSNTapDelegate : NSObject <UIGestureRecognizerDelegate>
@property CSNAd *ad;
@property uint64_t componentID;
@property CSNAdsController *adsController;
-(void) tapViewAction:(UIGestureRecognizer *)sender;
@end

@implementation CSNTapDelegate
- (void) tapViewAction:(UIGestureRecognizer *)sender {
    [_adsController openModal:_ad componentID:_componentID interactionKind:CSNPComponentInteractionKind_Tap];
}
@end

@implementation CSNAdsController

CSNModalWindow *modalWindowView;

- (instancetype) initWithAdUnit:(NSString *)adUnit {
    NSUUID *adUnitUUID = [[NSUUID alloc] initWithUUIDString:adUnit];
    uuid_t uuid;
    [adUnitUUID getUUIDBytes:uuid];
    NSData *adUnitData = [NSData dataWithBytes:uuid length:16];
    return [self initWithClient:[[CSNHttpClient alloc] initWithHost:@"api.commutestream.com"] adUnit:adUnitData];
}

- (instancetype) initMocked {
    uuid_t uuid = {0, 0, 0, 0, 0, 0 , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    NSData *empty = [NSData dataWithBytes:uuid length:16];
    return [self initWithClient:[[CSNMockClient alloc] init] adUnit:empty];
}

- (instancetype) initWithClient:(id<CSNClient>)client adUnit:(NSData *)adUnit {
    // get device id
    NSUUID *vendorID = [[UIDevice currentDevice] identifierForVendor];
    uuid_t vendorUUID;
    [vendorID getUUIDBytes:vendorUUID];
    NSData *deviceID = [[NSData alloc] initWithBytes:vendorUUID length:16];
    _deviceID = [[CSNPDeviceID alloc] init];
    [_deviceID setDeviceIdType:CSNPDeviceID_Type_Idfa];
    [_deviceID setDeviceId:deviceID];
    
    // get ip addresses
    _ipAddresses = [self getIpAddresses];
    
    // get timezone
    _timeZone = [[NSTimeZone localTimeZone] name];
    
    _client = client;
    _visMonitor = [[CSNVisibilityMonitor alloc] init];
    _reportsBuilder = [[CSNAdReportsBuilder alloc] initWithAdUnit:_adUnit deviceID:_deviceID ipAddresses:_ipAddresses timeZone:_timeZone];
    
    // send reports timer
    _reportsTimer = [NSTimer timerWithTimeInterval:30.0 repeats:true block:^(NSTimer * _Nonnull timer) {
        [self sendReports];
    }];
    [[NSRunLoop mainRunLoop] addTimer:_reportsTimer forMode:NSDefaultRunLoopMode];
    return self;
}

- (void) fetchAds:(NSArray<CSNAdRequest *> *)adRequests completed:(void (^)(NSArray<CSNOptionalAd *> *))completed {
    CSNPAdRequests *adRequestsMessage = [self buildRequestsMessage:adRequests];
    [_client getAds:adRequestsMessage success:^(CSNPAdResponses *adResponsesMessage) {
        NSArray *ads = [self buildAds:adRequests response:adResponsesMessage];
        completed(ads);
    } failure:^(NSError *error) {
        // on failure, log
        NSLog(@"CSNAdsController fetch ads failed, cause %@", error);
    }];
}

- (CSNPAdRequests *) buildRequestsMessage:(NSArray<CSNAdRequest *> *)adRequests {
    NSMutableDictionary *uniqueAdRequests = [[NSMutableDictionary alloc] initWithCapacity:[adRequests count]];
    CSNPAdRequests *adRequestsMsg = [[CSNPAdRequests alloc] init];
    [adRequestsMsg setIpAddressesArray:[NSMutableArray arrayWithArray:_ipAddresses]];
    [adRequestsMsg setAdUnit:_adUnit];
    [adRequestsMsg setDeviceId:_deviceID];
    [adRequestsMsg setTimezone:_timeZone];
    for(id adRequest in adRequests) {
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
    return adRequestsMsg;
}

- (NSArray<CSNOptionalAd *> *) buildAds:(NSArray<CSNAdRequest *> *)adRequests response:(CSNPAdResponses *)adResponses {
    NSMutableDictionary *hashedIndices = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *hashedResponses = [[NSMutableDictionary alloc] init];
    NSMutableArray<CSNOptionalAd *> *ads = [[NSMutableArray alloc] initWithCapacity:[adRequests count]];
    for(id adResponse in [adResponses adResponsesArray]) {
        [hashedResponses setObject:adResponse forKey:[adResponse hashId]];
        [hashedIndices setObject:[NSNumber numberWithUnsignedInteger:0] forKey:[adResponse hashId]];
    }
    for(id adRequest in adRequests) {
        NSData *hash = [adRequest sha256];
        NSNumber *index = [hashedIndices objectForKey:hash];
        NSUInteger indexval = [index unsignedIntegerValue];
        CSNPAdResponse *response = [hashedResponses objectForKey:hash];
        if(index && response && indexval < [response adsArray_Count]) {
            
            CSNPNativeAd *adMessage = [[response adsArray] objectAtIndex:indexval];

            CSNAd *ad = [[CSNAd alloc] initWithMessage:adMessage];
            CSNOptionalAd *optionalAd = [[CSNOptionalAd alloc] initWithAd:ad];
            [ads addObject:optionalAd];
            [hashedIndices setObject:[NSNumber numberWithUnsignedInteger:indexval+1] forKey:hash];
        } else {
            CSNOptionalAd *optionalAd = [[CSNOptionalAd alloc] initWithoutAd];
            [ads addObject:optionalAd];
        }
    }
    return ads;
}

- (void) buildView:(UIView *)view ad:(CSNAd *)ad parentTouch:(bool)parentTouch {
    if(view != nil && ad != nil) {
        [self setupComponentViews:view ad:ad parentTouch:parentTouch];
    }
}

- (NSArray *) componentViews:(UIView *)parent {
    return [self findViews:parent matcher:^bool(UIView *view) {
        return [view conformsToProtocol:@protocol(CSNComponentView)];
    }];
}

- (NSArray *) findViews:(UIView *)parent matcher:(bool (^)(UIView *))matcher {
    NSMutableArray *views = [[NSMutableArray alloc] init];
    [self findViews:parent views:views matcher:matcher];
    return views;
}

- (void) findViews:(UIView *)parent views:(NSMutableArray *)views matcher:(bool (^)(UIView *))matcher {
    if([[parent subviews] count] == 0) {
        return;
    }
    for(id subview in [parent subviews]) {
        if(matcher(subview)) {
            [views addObject:subview];
        }
        [self findViews:subview views:views matcher:matcher];
    }
}

- (void) setupComponentViews:(UIView *)parent ad:(CSNAd *)ad parentTouch:(bool)parentTouch {
    
    for(id<CSNComponentView> componentView in [self componentViews:parent]) {
        [componentView setAd:ad];
        [_visMonitor addView:componentView];
        [self setTapHandler:parent ad:ad componentID:[[ad view] componentID]];
    }
    if(parentTouch) {
        [self setTapHandler:parent ad:ad componentID:[[ad view] componentID]];
    }
}

- (void) setTapHandler:(UIView *)view ad:(CSNAd *)ad componentID:(uint64_t)componentID {
    CSNTapDelegate *tapDelegate = [[CSNTapDelegate alloc] init];
    [tapDelegate setAd:ad];
    [tapDelegate setComponentID:componentID];
    [tapDelegate setAdsController:self];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:tapDelegate action:@selector(tapViewAction:)];
    [view addGestureRecognizer:tapRecognizer];
    [view setUserInteractionEnabled:YES];
}

- (NSArray<NSData *> *) getIpAddresses {
    NSMutableArray *addrs = [[NSMutableArray alloc] init];
    struct ifaddrs *ifa, *ifa_tmp;
    
    if (getifaddrs(&ifa) == -1) {
        return addrs;
    }
    
    ifa_tmp = ifa;
    while (ifa_tmp) {
        if ((ifa_tmp->ifa_addr) && ((ifa_tmp->ifa_addr->sa_family == AF_INET) ||
                                    (ifa_tmp->ifa_addr->sa_family == AF_INET6))) {
            if (ifa_tmp->ifa_addr->sa_family == AF_INET) {
                // create IPv4 string
                struct sockaddr_in *in = (struct sockaddr_in*) ifa_tmp->ifa_addr;
                NSData *addr = [NSData dataWithBytes:&in->sin_addr length:in->sin_len];
                [addrs addObject:addr];
            } else { // AF_INET6
                // create IPv6 string
                struct sockaddr_in6 *in6 = (struct sockaddr_in6*) ifa_tmp->ifa_addr;
                NSData *addr = [NSData dataWithBytes:&in6->sin6_addr length:in6->sin6_len];
                [addrs addObject:addr];
            }
        }
        ifa_tmp = ifa_tmp->ifa_next;
    }
    freeifaddrs(ifa);
    return addrs;
}

- (void) sendReports {
    CSNPAdReports *reports = [_reportsBuilder buildReport];
    [_client sendAdReports:reports success:^{
    } failure:^(NSError *error) {
    }];
}

- (void) openModal:(CSNAd *)ad componentID:(uint64_t)componentID interactionKind:(int32_t)interactionKind{
    [_reportsBuilder recordInteraction:[ad requestID] adID:[ad adID] componentID:componentID interactionKind:interactionKind];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CSNModalWindow *modalWindow = [[CSNModalWindow alloc] initWithFrame:bounds forAd:ad];
    modalWindow.windowLevel = UIWindowLevelAlert;
    [_visMonitor addView:[modalWindow getSecondaryActionView]];
    modalWindowView = modalWindow;
    [modalWindow makeKeyAndVisible];
}

@end
