@import AdSupport;
#import "CSNSDKVersion.h"
#import "CSNAdsController.h"
#import "CSNAdUnitSettings.h"
#import "CSNClientInfo.h"
#import "CSNClient.h"
#import "CSNHttpClient.h"
#import "CSNAdRequestTask.h"
#import "CSNMockClient.h"
#import "CSNLogoView.h"
#import "CSNLocationManager.h"
#import "CSNModalWindow.h"
#import "CSNVisibilityMonitor.h"
#import "CSNAdReportsBuilder.h"
#import "Csnmessages.pbobjc.h"



@interface CSNAdsController ()
@property id<CSNClient> client;
@property CSNVisibilityMonitor *visMonitor;
@property CSNAdUnitSettings *settings;
@property NSTimer *marketsRetryTimer;
@property CSNClientInfo *clientInfo;
@property NSMutableArray *pendingRequests;
@property CSNAdRequestTask *adRequestTask;
@property NSMapTable* tapDelegates;
@property CSNAdReportsBuilder *reportsBuilder;
@property NSTimer *reportsTimer;
- (void) openModal:(CSNAd *)ad componentID:(uint64_t)componentID interactionKind:(int32_t)interactionKind;
@end
@interface CSNPendingAdRequests : NSObject
@property NSArray<CSNAdRequest *> *adRequests;
@property void (^completed)(NSArray<CSNOptionalAd *> *);
@end

@implementation CSNPendingAdRequests
@end

@interface CSNTapDelegate : NSObject <UIGestureRecognizerDelegate>
@property CSNAd *ad;
@property uint64_t componentID;
@property CSNAdsController *adsController;
-(void) tapViewAction:(UIGestureRecognizer *)sender;
@end

@implementation CSNTapDelegate
- (void) dealloc {
    NSLog(@"de-allocating tap delegate for ad %lld", [_ad adID]);
}
- (void) tapViewAction:(UIGestureRecognizer *)sender {
    [_adsController openModal:_ad componentID:_componentID interactionKind:CSNPComponentInteractionKind_Tap];
}
@end

@implementation CSNAdsController

CSNModalWindow *modalWindowView;

- (instancetype) initWithAdUnit:(NSString *)adUnit {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:adUnit];

    return [self initWithClient:[[CSNHttpClient alloc] initWithHost:@"api.commutestream.com" requestTimeout:5 responseTimeout:5] adUnit:uuid];
}

- (instancetype) initMocked {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"00000-000-000000-00000"];
    CSNMockClient *mockClient = [[CSNMockClient alloc] init];
    CSNAdUnitSettings *adUnitSettings = [[CSNAdUnitSettings alloc] init];
    [adUnitSettings setEnabled:true];
    [adUnitSettings setAgencies:[NSSet setWithObjects:@"commutestream", nil]];
    [mockClient setMockedAdUnitSettings:adUnitSettings];
    return [self initWithClient:mockClient adUnit:uuid];
}

- (void) loadSettings {
    // get settings
    CSNAdsController *adsController = self;
    [_client getAdUnitSettings:_clientInfo.adUnit success:^(CSNAdUnitSettings *settings) {
        [adsController setSettings:settings];
        [adsController fetchPending];
    } failure:^(NSError *error) {
        NSLog(@"Error getting ad unit settings %@, retrying in 10s", error );
        _marketsRetryTimer = [NSTimer timerWithTimeInterval:10.0 repeats:false block:^(NSTimer * _Nonnull timer) {
        
            [adsController loadSettings];
        }];
        [[NSRunLoop mainRunLoop] addTimer:_marketsRetryTimer forMode:NSDefaultRunLoopMode];
    }];
}

- (instancetype) initWithClient:(id<CSNClient>)client adUnit:(NSUUID *)adUnit {
    _client = client;
    _clientInfo = [[CSNClientInfo alloc] initWithAdUnit:adUnit];
    _pendingRequests = [[NSMutableArray alloc] init];
    [self loadSettings];

    _reportsBuilder = [[CSNAdReportsBuilder alloc] initWithClientInfo:_clientInfo];
    // send reports timer
    _reportsTimer = [NSTimer timerWithTimeInterval:15.0 target:self selector:@selector(sendReports) userInfo:nil repeats:YES];
    _visMonitor = [[CSNVisibilityMonitor alloc] initWithReportsBuilder:_reportsBuilder];
    _tapDelegates = [[NSMapTable alloc] initWithKeyOptions:NSMapTableWeakMemory valueOptions:NSMapTableStrongMemory capacity:10];
    [[NSRunLoop mainRunLoop] addTimer:_reportsTimer forMode:NSDefaultRunLoopMode];
    return self;
}

- (bool) isReady {
    return _settings != nil;
}

- (void) fetchAds:(NSArray<CSNAdRequest *> *)adRequests completed:(void (^)(NSArray<CSNOptionalAd *> *))completed {
    if([self isReady]) {
        [self doFetchAds:adRequests completed:completed];
    } else {
        CSNPendingAdRequests *pendingRequest = [[CSNPendingAdRequests alloc] init];
        pendingRequest.adRequests = adRequests;
        pendingRequest.completed = completed;
        [_pendingRequests addObject:pendingRequest];
    }
}

- (void) doFetchAds:(NSArray<CSNAdRequest *> *)adRequests
          completed:(void (^)(NSArray<CSNOptionalAd *> *))completed
{
    _adRequestTask = [[CSNAdRequestTask alloc] initWithClient:_client
                                                   clientInfo:_clientInfo
                                                     settings:_settings
                                                     requests:adRequests
                                                    completed:completed];
}

- (void) fetchPending {
    if([self isReady] && _pendingRequests) {
        for(CSNPendingAdRequests *pendingRequest in _pendingRequests) {
            [self doFetchAds:pendingRequest.adRequests completed:pendingRequest.completed];
        }
        [_pendingRequests removeAllObjects];
    }
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
        [self setTapHandler:(UIView *)componentView ad:ad componentID:[componentView componentID]];
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
    [tapRecognizer setNumberOfTapsRequired:1];
    //[tapRecognizer setDelegate:tapRecognizer];
    [view addGestureRecognizer:tapRecognizer];
    [view setUserInteractionEnabled:YES];
    [_tapDelegates setObject:tapDelegate forKey:view];
}



- (void) sendReports {
    // update device id, ip addresses, and location of report before sending
    // will periodically cause the device and ip addresses to be refreshed (every 30s)
    [_clientInfo updateDeviceID];
    [_clientInfo updateIpAddresses];
    [_reportsBuilder setDeviceID:_clientInfo.deviceID];
    [_reportsBuilder setIpAddresses:_clientInfo.ipAddresses];
    [_reportsBuilder setLocations:[[CSNLocationManager sharedLocationManager] getLocations]];
    CSNPAdReports *reports = [_reportsBuilder buildReport];
    [_client sendAdReports:reports success:^{
    } failure:^(NSError *error) {
    }];
}

- (void) openModal:(CSNAd *)ad componentID:(uint64_t)componentID interactionKind:(int32_t)interactionKind{
    [_reportsBuilder recordInteraction:[ad requestID] adID:[ad adID] versionID:[ad versionID] componentID:componentID interactionKind:interactionKind];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CSNModalWindow *modalWindow = [[CSNModalWindow alloc] initWithFrame:bounds forAd:ad withReportsBuilder:_reportsBuilder];
    modalWindow.windowLevel = UIWindowLevelNormal;
    [_visMonitor addView:[modalWindow getSecondaryActionView]];
    modalWindowView = modalWindow;
    [modalWindow makeKeyAndVisible];
}

- (void) applicationDidEnterBackground {
    [self sendReports];
}

@end
