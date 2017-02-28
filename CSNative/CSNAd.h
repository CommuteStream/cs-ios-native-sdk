@import Foundation;
@import UIKit;


@protocol CSNAdComponent
@property (readonly) uint64_t componentID;
@end

@interface CSNTitleComponent : NSObject <CSNAdComponent>
@property (readonly) uint64_t componentID;
@property (readonly, nonnull) NSString *title;
@end;

@interface CSNLocationComponent : NSObject <CSNAdComponent>
@property (readonly) uint64_t componentID;
@property (readonly, nonnull) NSString *name;
@property (readonly) double latitude;
@property (readonly) double longitude;
@property (readonly, nonnull) NSString *address;
@end

@interface CSNIconComponent : NSObject <CSNAdComponent>
@property (readonly) uint64_t componentID;
@property (readonly, nonnull) UIImage *image;
@end

@interface CSNActionComponent : NSObject <CSNAdComponent>
@property (readonly) uint64_t componentID;
@property (readonly, nonnull) NSString *kind;
@property (readonly, nonnull) NSString *url;
@end

@interface CSNHeroComponent : NSObject <CSNAdComponent>
@property (readonly) uint64_t componentID;
@property (readonly, nonnull) NSString *kind;
@property (readonly, nonnull) NSData *blob;
@end

@interface CSNAd : NSObject
@property (readonly) uint64_t requestID;
@property (readonly) uint64_t adID;
@property (readonly, nonnull) CSNTitleComponent *title;
@property (readonly, nonnull) CSNIconComponent *icon;
@property (readonly, nullable) CSNLocationComponent *location;
@property (readonly, nonnull) CSNHeroComponent *hero;
@property (readonly, nonnull) NSArray<CSNActionComponent *> *actions;
@end
