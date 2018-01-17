@import Foundation
@import CoreLocation
@import UIKit

@interface CSNLocationManager : NSObject

/**
 * Returns the shared instance of the `MPGeolocationProvider` class.
 *
 * @return The shared instance of the `MPGeolocationProvider` class.
 */
+ (instancetype)sharedProvider;

/**
 * The most recent location determined by the location provider.
 */
@property (nonatomic, readonly) CLLocation *lastKnownLocation;

/**
 * Determines whether the location provider should attempt to listen for location updates. The
 * default value is YES.
 */
@property (nonatomic, assign) BOOL locationUpdatesEnabled;



@end
