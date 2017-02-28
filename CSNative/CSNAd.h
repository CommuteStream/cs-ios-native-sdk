@import Foundation;
@import UIKit;
#import "Csnmessages.pbobjc.h"

@protocol CSNAdComponent
@property (readonly) uint64_t componentID;
@end

@interface CSNTitleComponent : NSObject <CSNAdComponent>
@property (readonly) uint64_t componentID;
@property (copy, readonly, nonnull) NSString *title;

- (instancetype _Nonnull) initWithMessage:(CSNPTitleComponent * _Nonnull)message;
@end;

@interface CSNLocationComponent : NSObject <CSNAdComponent>
@property (readonly) uint64_t componentID;
@property (readonly) double latitude;
@property (readonly) double longitude;
@property (copy, readonly, nonnull) NSString *name;
@property (copy, readonly, nonnull) NSString *address;

- (instancetype _Nonnull) initWithMessage:(CSNPLocationComponent * _Nonnull)message;
@end

@interface CSNIconComponent : NSObject <CSNAdComponent>
@property (readonly) uint64_t componentID;
@property (copy, readonly, nonnull) UIImage *image;

- (instancetype _Nonnull) initWithMessage:(CSNPIconComponent * _Nonnull)message;
@end

@interface CSNActionComponent : NSObject <CSNAdComponent>
@property (readonly) uint64_t componentID;
@property (copy, readonly, nonnull) NSString *kind;
@property (copy, readonly, nonnull) NSString *url;

- (instancetype _Nonnull) initWithMessage:(CSNPActionComponent * _Nonnull)message;
@end

@interface CSNHeroComponent : NSObject <CSNAdComponent>
@property (readonly) uint64_t componentID;
@property (copy, readonly, nonnull) NSString *kind;
@property (copy, readonly, nonnull) NSData *blob;

- (instancetype _Nonnull) initWithMessage:(CSNPHeroComponent * _Nonnull)message;
@end

@interface CSNAd : NSObject
@property (readonly) uint64_t requestID;
@property ( readonly) uint64_t adID;
@property (copy, readonly, nonnull) CSNTitleComponent *title;
@property (copy, readonly, nonnull) CSNIconComponent *icon;
@property (copy, readonly, nullable) CSNLocationComponent *location;
@property (copy, readonly, nonnull) CSNHeroComponent *hero;
@property (copy, readonly, nonnull) NSArray<CSNActionComponent *> *actions;

- (instancetype _Nonnull) initWithMessage:(CSNPNativeAd * _Nonnull)message;
@end
