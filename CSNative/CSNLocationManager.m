#import "CSNLocationManager.h"

const CLLocationDistance kDistanceFilter = 50.0; // distance in meters that must change for update to be recieved

@interface CSNLocationManager () <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic, readwrite) CLLocation *lastLocation;
@property (nonatomic) NSDate *lastUpdate;
@property (nonatomic) bool automaticUpdatesEnabled;
@property (nonatomic, readwrite) NSMutableArray<CLLocation *> *locations;

@end


@implementation CSNLocationManager

+ (instancetype) sharedLocationManager
{
    static CSNLocationManager *sharedLocationManager = nil;
    @synchronized(self) {
        if (sharedLocationManager == nil)
            sharedLocationManager = [[self alloc] init];
    }
    return sharedLocationManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _automaticUpdatesEnabled = false;
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.distanceFilter = kDistanceFilter;
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locations = [[NSMutableArray alloc] init];
        
        // Avoid processing location updates when the application enters the background.
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:[UIApplication sharedApplication] queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            [self stopUpdates];
        }];
        
        // Re-activate location updates when the application comes back to the foreground.
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillEnterForegroundNotification object:[UIApplication sharedApplication] queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            [self startUpdates];
        }];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:[UIApplication sharedApplication]];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:[UIApplication sharedApplication]];
}

#pragma mark - Public

-(NSArray<CSNPDeviceLocation* > *)getLocations
{
    [self checkRecentLocation];
    NSMutableArray<CSNPDeviceLocation *> *locations = [[NSMutableArray alloc] initWithCapacity:[_locations count]];
    for(CLLocation *location in _locations) {
        [locations addObject:[self encodeLocation:location]];
    }
    [_locations removeAllObjects];
    if([locations count] == 0 && _lastLocation) {
        [locations addObject:[self encodeLocation:_lastLocation]];
    }
    return locations;
}

-(void)enableAutomaticUpdates
{
    if(!_automaticUpdatesEnabled) {
        _automaticUpdatesEnabled = true;
        [self startUpdates];
    }
}

-(void)disableAutomaticUpdates
{
    if(_automaticUpdatesEnabled) {
        _automaticUpdatesEnabled = false;
        [self stopUpdates];
    }
}

#pragma mark - Internal

- (CSNPDeviceLocation *) encodeLocation:(CLLocation *)location {
    uint64_t timestamp = [[location timestamp] timeIntervalSince1970] * 1000.0;
    CSNPDeviceLocation *deviceLocation = [[CSNPDeviceLocation alloc] init];
    [deviceLocation setTimestamp:timestamp];
    [deviceLocation setLatitude:location.coordinate.latitude];
    [deviceLocation setLongitude:location.coordinate.longitude];
    [deviceLocation setAltitude:location.altitude];
    [deviceLocation setBearing:location.course];
    [deviceLocation setSpeed:location.speed];
    [deviceLocation setHorizontalAccuracy:location.horizontalAccuracy];
    [deviceLocation setVerticalAccuracy:location.verticalAccuracy];
    return deviceLocation;
}

-(void)checkRecentLocation {
    CLLocation *recentLocation = _locationManager.location;
    if(_lastLocation != recentLocation) {
        [self addLocation:recentLocation];
    }
}

- (BOOL)isAuthorizedStatus:(CLAuthorizationStatus)status
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    return (status == kCLAuthorizationStatusAuthorizedAlways) || (status == kCLAuthorizationStatusAuthorizedWhenInUse);
#else
    return status == kCLAuthorizationStatusAuthorized;
#endif
}

/**
 * Start recurring location updates or timer to check for periodically check for location services being enabled
 */
- (void)startUpdates
{
    // if automatic updates have been disabled then give up on starting updates
    if(!_automaticUpdatesEnabled) {
        return;
    }
    
    if ([CLLocationManager locationServicesEnabled] && [self isAuthorizedStatus:[CLLocationManager authorizationStatus]]) {
        NSLog(@"Start automatically updating location");
        [self addLocation:_locationManager.location];
        [self.locationManager startUpdatingLocation];
    } else {
        NSLog(@"Not automatically updating location, not authorized or enabled");
    }
}

- (void)stopUpdates
{
    NSLog(@"Stop automatically updating location.");
    [self.locationManager stopUpdatingLocation];
}

- (void)addLocations:(NSArray *)locations
{
    for (CLLocation *location in locations) {
        [self addLocation:location];
    }
}

- (void) addLocation:(CLLocation *)location
{
    if(!location) {
        return;
    }
    _lastLocation = location;
    _lastUpdate = [[NSDate alloc] init];
    [_locations addObject:location];
}

#pragma mark - <CLLocationManagerDelegate> (iOS 6.0+)

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"Location authorization status changed to: %ld", (long)status);
    
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            [self stopUpdates];
            break;
        case kCLAuthorizationStatusAuthorizedAlways: // same as kCLAuthorizationStatusAuthorized
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
        case kCLAuthorizationStatusAuthorizedWhenInUse:
#endif
            [self startUpdates];
            break;
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self addLocations:locations];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (error.code == kCLErrorDenied) {
        NSLog(@"Location manager failed: the user has denied access to location services.");
        [self stopUpdates];
    } else if (error.code == kCLErrorLocationUnknown) {
        NSLog(@"Location manager could not obtain a location right now.");
    }
}


@end

