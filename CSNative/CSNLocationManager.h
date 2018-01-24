@import Foundation;
@import CoreLocation;
@import UIKit;

#import "Csnmessages.pbobjc.h"

@interface CSNLocationManager : NSObject

/**
 * Get a pointer to the location manager singleton
 */
+ (instancetype)sharedLocationManager;

/**
 * Get an array containing all the recently updated locations that have been queued. Always nonnull,
 * will always return the last known location of the device if available.
 * Automatically updates when location changes are seen.
 */
-(NSArray<CSNPDeviceLocation * > *)getLocations;

/**
 * Enable automatic updates
 */
-(void)enableAutomaticUpdates;

/**
 * Disable automatic updates
 */
-(void)disableAutomaticUpdates;

@end
