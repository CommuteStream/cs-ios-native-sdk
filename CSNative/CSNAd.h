@import Foundation;
@import UIKit;
#import "Csnmessages.pbobjc.h"

@protocol CSNAdComponent
@property (readonly) uint64_t componentID;
@end

@interface CSNColors : NSObject
@property (readonly, nonnull) UIColor *foreground;
@property (readonly, nonnull) UIColor *background;
- (instancetype _Nonnull) initWithMessage:(CSNPColors * _Nonnull)message;
@end

@interface CSNViewComponent : NSObject <CSNAdComponent>
@property (readonly) uint64_t componentID;
- (instancetype _Nonnull) initWithMessage:(CSNPViewComponent * _Nonnull)message;
@end

@interface CSNHeadlineComponent : NSObject <CSNAdComponent>
@property (readonly) uint64_t componentID;
@property (copy, readonly, nonnull) NSString *headline;
- (instancetype _Nonnull) initWithMessage:(CSNPHeadlineComponent * _Nonnull)message;
@end

@interface CSNBodyComponent : NSObject <CSNAdComponent>
@property (readonly) uint64_t componentID;
@property (copy, readonly, nonnull) NSString *body;
- (instancetype _Nonnull) initWithMessage:(CSNPBodyComponent * _Nonnull)message;
@end;

@interface CSNAdvertiserComponent : NSObject <CSNAdComponent>
@property (readonly) uint64_t componentID;
@property (copy, readonly, nonnull) NSString *advertiser;
- (instancetype _Nonnull) initWithMessage:(CSNPAdvertiserComponent * _Nonnull)message;
@end;

@interface CSNSecondaryActionComponent : NSObject <CSNAdComponent>
@property (readonly) uint64_t componentID;
@property (copy, readonly, nonnull) NSString *title;
@property (copy, readonly, nonnull) NSString *subtitle;
- (instancetype _Nonnull) initWithMessage:(CSNPSecondaryActionComponent * _Nonnull)message;
@end;

@interface CSNLocationComponent : NSObject <CSNAdComponent>
@property (readonly) uint64_t componentID;
@property (readonly) double latitude;
@property (readonly) double longitude;
@property (copy, readonly, nonnull) NSString *name;
@property (copy, readonly, nonnull) NSString *address;
- (instancetype _Nonnull) initWithMessage:(CSNPLocationComponent * _Nonnull)message;
@end

@interface CSNLogoComponent : NSObject <CSNAdComponent>
@property (readonly) uint64_t componentID;
@property (copy, readonly, nonnull) UIImage *image;
- (instancetype _Nonnull) initWithMessage:(CSNPLogoComponent * _Nonnull)message;
@end

@interface CSNActionComponent : NSObject <CSNAdComponent>
@property (readonly) uint64_t componentID;
@property (readonly) CSNPActionKind kind;
@property (copy, readonly, nonnull) NSString *url;
@property (copy, readonly, nonnull) NSString *title;
@property (copy, readonly, nonnull) CSNColors *colors;

- (instancetype _Nonnull) initWithMessage:(CSNPActionComponent * _Nonnull)message;
@end

@interface CSNHeroComponent : NSObject <CSNAdComponent>
@property (readonly) uint64_t componentID;
@property (readonly) CSNPHeroKind kind;
@property (copy, readonly, nonnull) UIImage *image;
@property (copy, readonly, nonnull) NSString *html;
- (instancetype _Nonnull) initWithMessage:(CSNPHeroComponent * _Nonnull)message;
@end

@interface CSNAd : NSObject
@property (readonly) uint64_t requestID;
@property (readonly) uint64_t adID;
@property (readonly) uint64_t versionID;
@property (copy, readonly, nonnull) CSNViewComponent *view;
@property (copy, readonly, nonnull) CSNHeadlineComponent *headline;
@property (copy, readonly, nonnull) CSNBodyComponent *body;
@property (copy, readonly, nonnull) CSNAdvertiserComponent *advertiser;
@property (copy, readonly, nonnull) CSNLogoComponent *logo;
@property (copy, readonly, nullable) CSNLocationComponent *location;
@property (copy, readonly, nonnull) CSNHeroComponent *hero;
@property (copy, readonly, nonnull) CSNSecondaryActionComponent *secondary;
@property (copy, readonly, nonnull) NSArray<CSNActionComponent *> *actions;
- (instancetype _Nonnull) initWithMessage:(CSNPNativeAd * _Nonnull)message;
@end
