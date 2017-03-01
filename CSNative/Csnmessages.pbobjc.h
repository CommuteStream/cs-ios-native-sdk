// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: csnmessages.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30002
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30002 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

@class CSNPActionComponent;
@class CSNPAdInteraction;
@class CSNPAdVisibility;
@class CSNPColors;
@class CSNPDeviceID;
@class CSNPHeroComponent;
@class CSNPIconComponent;
@class CSNPLocation;
@class CSNPLocationAd;
@class CSNPLocationComponent;
@class CSNPNativeAd;
@class CSNPSimpleStat;
@class CSNPStop;
@class CSNPStopAd;
@class CSNPStopComponent;
@class CSNPTitleComponent;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum CSNPHeroKind

typedef GPB_ENUM(CSNPHeroKind) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  CSNPHeroKind_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  CSNPHeroKind_Image = 0,
  CSNPHeroKind_Html = 1,
};

GPBEnumDescriptor *CSNPHeroKind_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL CSNPHeroKind_IsValidValue(int32_t value);

#pragma mark - Enum CSNPActionKind

typedef GPB_ENUM(CSNPActionKind) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  CSNPActionKind_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  CSNPActionKind_URL = 0,
};

GPBEnumDescriptor *CSNPActionKind_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL CSNPActionKind_IsValidValue(int32_t value);

#pragma mark - Enum CSNPAdInteractionKind

typedef GPB_ENUM(CSNPAdInteractionKind) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  CSNPAdInteractionKind_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  CSNPAdInteractionKind_Tap = 0,
};

GPBEnumDescriptor *CSNPAdInteractionKind_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL CSNPAdInteractionKind_IsValidValue(int32_t value);

#pragma mark - Enum CSNPDeviceID_Type

typedef GPB_ENUM(CSNPDeviceID_Type) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  CSNPDeviceID_Type_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  CSNPDeviceID_Type_Idfa = 0,
  CSNPDeviceID_Type_Aaid = 1,
};

GPBEnumDescriptor *CSNPDeviceID_Type_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL CSNPDeviceID_Type_IsValidValue(int32_t value);

#pragma mark - CSNPCsnmessagesRoot

/**
 * Exposes the extension registry for this file.
 *
 * The base class provides:
 * @code
 *   + (GPBExtensionRegistry *)extensionRegistry;
 * @endcode
 * which is a @c GPBExtensionRegistry that includes all the extensions defined by
 * this file and all files that it depends on.
 **/
@interface CSNPCsnmessagesRoot : GPBRootObject
@end

#pragma mark - CSNPStop

typedef GPB_ENUM(CSNPStop_FieldNumber) {
  CSNPStop_FieldNumber_AgencyId = 1,
  CSNPStop_FieldNumber_RouteId = 2,
  CSNPStop_FieldNumber_StopId = 3,
};

@interface CSNPStop : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *agencyId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *routeId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *stopId;

@end

#pragma mark - CSNPStopComponent

typedef GPB_ENUM(CSNPStopComponent_FieldNumber) {
  CSNPStopComponent_FieldNumber_ComponentId = 1,
  CSNPStopComponent_FieldNumber_StopTuple = 2,
  CSNPStopComponent_FieldNumber_AgencyName = 3,
  CSNPStopComponent_FieldNumber_RouteName = 4,
  CSNPStopComponent_FieldNumber_StopName = 5,
};

@interface CSNPStopComponent : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *componentId;

@property(nonatomic, readwrite, strong, null_resettable) CSNPStop *stopTuple;
/** Test to see if @c stopTuple has been set. */
@property(nonatomic, readwrite) BOOL hasStopTuple;

@property(nonatomic, readwrite, copy, null_resettable) NSString *agencyName;

@property(nonatomic, readwrite, copy, null_resettable) NSString *routeName;

@property(nonatomic, readwrite, copy, null_resettable) NSString *stopName;

@end

#pragma mark - CSNPLocation

typedef GPB_ENUM(CSNPLocation_FieldNumber) {
  CSNPLocation_FieldNumber_Lat = 2,
  CSNPLocation_FieldNumber_Lon = 3,
};

@interface CSNPLocation : GPBMessage

@property(nonatomic, readwrite) double lat;

@property(nonatomic, readwrite) double lon;

@end

#pragma mark - CSNPLocationComponent

typedef GPB_ENUM(CSNPLocationComponent_FieldNumber) {
  CSNPLocationComponent_FieldNumber_ComponentId = 1,
  CSNPLocationComponent_FieldNumber_Location = 2,
  CSNPLocationComponent_FieldNumber_Name = 3,
  CSNPLocationComponent_FieldNumber_Address = 4,
};

@interface CSNPLocationComponent : GPBMessage

@property(nonatomic, readwrite) uint64_t componentId;

@property(nonatomic, readwrite, strong, null_resettable) CSNPLocation *location;
/** Test to see if @c location has been set. */
@property(nonatomic, readwrite) BOOL hasLocation;

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@property(nonatomic, readwrite, copy, null_resettable) NSString *address;

@end

#pragma mark - CSNPHeroComponent

typedef GPB_ENUM(CSNPHeroComponent_FieldNumber) {
  CSNPHeroComponent_FieldNumber_ComponentId = 1,
  CSNPHeroComponent_FieldNumber_Kind = 2,
  CSNPHeroComponent_FieldNumber_Blob = 3,
};

@interface CSNPHeroComponent : GPBMessage

@property(nonatomic, readwrite) uint64_t componentId;

@property(nonatomic, readwrite) CSNPHeroKind kind;

@property(nonatomic, readwrite, copy, null_resettable) NSData *blob;

@end

/**
 * Fetches the raw value of a @c CSNPHeroComponent's @c kind property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t CSNPHeroComponent_Kind_RawValue(CSNPHeroComponent *message);
/**
 * Sets the raw value of an @c CSNPHeroComponent's @c kind property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetCSNPHeroComponent_Kind_RawValue(CSNPHeroComponent *message, int32_t value);

#pragma mark - CSNPActionComponent

typedef GPB_ENUM(CSNPActionComponent_FieldNumber) {
  CSNPActionComponent_FieldNumber_ComponentId = 1,
  CSNPActionComponent_FieldNumber_Kind = 2,
  CSNPActionComponent_FieldNumber_URL = 3,
};

@interface CSNPActionComponent : GPBMessage

@property(nonatomic, readwrite) uint64_t componentId;

@property(nonatomic, readwrite) CSNPActionKind kind;

@property(nonatomic, readwrite, copy, null_resettable) NSString *URL;

@end

/**
 * Fetches the raw value of a @c CSNPActionComponent's @c kind property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t CSNPActionComponent_Kind_RawValue(CSNPActionComponent *message);
/**
 * Sets the raw value of an @c CSNPActionComponent's @c kind property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetCSNPActionComponent_Kind_RawValue(CSNPActionComponent *message, int32_t value);

#pragma mark - CSNPIconComponent

typedef GPB_ENUM(CSNPIconComponent_FieldNumber) {
  CSNPIconComponent_FieldNumber_ComponentId = 1,
  CSNPIconComponent_FieldNumber_Image = 2,
};

@interface CSNPIconComponent : GPBMessage

@property(nonatomic, readwrite) uint64_t componentId;

@property(nonatomic, readwrite, copy, null_resettable) NSData *image;

@end

#pragma mark - CSNPTitleComponent

typedef GPB_ENUM(CSNPTitleComponent_FieldNumber) {
  CSNPTitleComponent_FieldNumber_ComponentId = 1,
  CSNPTitleComponent_FieldNumber_Title = 2,
};

@interface CSNPTitleComponent : GPBMessage

@property(nonatomic, readwrite) uint64_t componentId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *title;

@end

#pragma mark - CSNPColors

typedef GPB_ENUM(CSNPColors_FieldNumber) {
  CSNPColors_FieldNumber_Background = 1,
  CSNPColors_FieldNumber_Foreground = 2,
};

@interface CSNPColors : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *background;

@property(nonatomic, readwrite, copy, null_resettable) NSString *foreground;

@end

#pragma mark - CSNPNativeAd

typedef GPB_ENUM(CSNPNativeAd_FieldNumber) {
  CSNPNativeAd_FieldNumber_RequestId = 1,
  CSNPNativeAd_FieldNumber_AdId = 2,
  CSNPNativeAd_FieldNumber_Colors = 3,
  CSNPNativeAd_FieldNumber_Icon = 4,
  CSNPNativeAd_FieldNumber_Title = 5,
  CSNPNativeAd_FieldNumber_Location = 6,
  CSNPNativeAd_FieldNumber_Stop = 7,
  CSNPNativeAd_FieldNumber_Hero = 8,
  CSNPNativeAd_FieldNumber_ActionsArray = 9,
};

@interface CSNPNativeAd : GPBMessage

@property(nonatomic, readwrite) uint64_t requestId;

@property(nonatomic, readwrite) uint64_t adId;

@property(nonatomic, readwrite, strong, null_resettable) CSNPColors *colors;
/** Test to see if @c colors has been set. */
@property(nonatomic, readwrite) BOOL hasColors;

@property(nonatomic, readwrite, strong, null_resettable) CSNPIconComponent *icon;
/** Test to see if @c icon has been set. */
@property(nonatomic, readwrite) BOOL hasIcon;

@property(nonatomic, readwrite, strong, null_resettable) CSNPTitleComponent *title;
/** Test to see if @c title has been set. */
@property(nonatomic, readwrite) BOOL hasTitle;

@property(nonatomic, readwrite, strong, null_resettable) CSNPLocationComponent *location;
/** Test to see if @c location has been set. */
@property(nonatomic, readwrite) BOOL hasLocation;

@property(nonatomic, readwrite, strong, null_resettable) CSNPStopComponent *stop;
/** Test to see if @c stop has been set. */
@property(nonatomic, readwrite) BOOL hasStop;

@property(nonatomic, readwrite, strong, null_resettable) CSNPHeroComponent *hero;
/** Test to see if @c hero has been set. */
@property(nonatomic, readwrite) BOOL hasHero;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<CSNPActionComponent*> *actionsArray;
/** The number of items in @c actionsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger actionsArray_Count;

@end

#pragma mark - CSNPStopAd

typedef GPB_ENUM(CSNPStopAd_FieldNumber) {
  CSNPStopAd_FieldNumber_Stop = 1,
  CSNPStopAd_FieldNumber_AdId = 2,
};

@interface CSNPStopAd : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) CSNPStop *stop;
/** Test to see if @c stop has been set. */
@property(nonatomic, readwrite) BOOL hasStop;

@property(nonatomic, readwrite) uint64_t adId;

@end

#pragma mark - CSNPLocationAd

typedef GPB_ENUM(CSNPLocationAd_FieldNumber) {
  CSNPLocationAd_FieldNumber_Loc = 1,
  CSNPLocationAd_FieldNumber_AdId = 2,
};

@interface CSNPLocationAd : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) CSNPLocation *loc;
/** Test to see if @c loc has been set. */
@property(nonatomic, readwrite) BOOL hasLoc;

@property(nonatomic, readwrite) uint64_t adId;

@end

#pragma mark - CSNPAdRequest

typedef GPB_ENUM(CSNPAdRequest_FieldNumber) {
  CSNPAdRequest_FieldNumber_AdUnit = 1,
  CSNPAdRequest_FieldNumber_DeviceId = 2,
  CSNPAdRequest_FieldNumber_Timezone = 3,
  CSNPAdRequest_FieldNumber_Location = 4,
  CSNPAdRequest_FieldNumber_StopsArray = 5,
};

@interface CSNPAdRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *adUnit;

@property(nonatomic, readwrite, strong, null_resettable) CSNPDeviceID *deviceId;
/** Test to see if @c deviceId has been set. */
@property(nonatomic, readwrite) BOOL hasDeviceId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *timezone;

@property(nonatomic, readwrite, strong, null_resettable) CSNPLocation *location;
/** Test to see if @c location has been set. */
@property(nonatomic, readwrite) BOOL hasLocation;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<CSNPStop*> *stopsArray;
/** The number of items in @c stopsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger stopsArray_Count;

@end

#pragma mark - CSNPAdResponse

typedef GPB_ENUM(CSNPAdResponse_FieldNumber) {
  CSNPAdResponse_FieldNumber_LocationAdsArray = 1,
  CSNPAdResponse_FieldNumber_StopAdsArray = 2,
  CSNPAdResponse_FieldNumber_Ads = 3,
};

@interface CSNPAdResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<CSNPLocationAd*> *locationAdsArray;
/** The number of items in @c locationAdsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger locationAdsArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<CSNPStopAd*> *stopAdsArray;
/** The number of items in @c stopAdsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger stopAdsArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) GPBUInt64ObjectDictionary<CSNPNativeAd*> *ads;
/** The number of items in @c ads without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger ads_Count;

@end

#pragma mark - CSNPDeviceID

typedef GPB_ENUM(CSNPDeviceID_FieldNumber) {
  CSNPDeviceID_FieldNumber_DeviceIdType = 1,
  CSNPDeviceID_FieldNumber_DeviceId = 2,
};

@interface CSNPDeviceID : GPBMessage

@property(nonatomic, readwrite) CSNPDeviceID_Type deviceIdType;

@property(nonatomic, readwrite, copy, null_resettable) NSString *deviceId;

@end

/**
 * Fetches the raw value of a @c CSNPDeviceID's @c deviceIdType property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t CSNPDeviceID_DeviceIdType_RawValue(CSNPDeviceID *message);
/**
 * Sets the raw value of an @c CSNPDeviceID's @c deviceIdType property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetCSNPDeviceID_DeviceIdType_RawValue(CSNPDeviceID *message, int32_t value);

#pragma mark - CSNPSimpleStat

typedef GPB_ENUM(CSNPSimpleStat_FieldNumber) {
  CSNPSimpleStat_FieldNumber_Min = 1,
  CSNPSimpleStat_FieldNumber_Max = 2,
  CSNPSimpleStat_FieldNumber_Mean = 3,
};

@interface CSNPSimpleStat : GPBMessage

@property(nonatomic, readwrite) double min;

@property(nonatomic, readwrite) double max;

@property(nonatomic, readwrite) double mean;

@end

#pragma mark - CSNPAdVisibility

typedef GPB_ENUM(CSNPAdVisibility_FieldNumber) {
  CSNPAdVisibility_FieldNumber_RequestId = 1,
  CSNPAdVisibility_FieldNumber_AdId = 2,
  CSNPAdVisibility_FieldNumber_ComponentId = 3,
  CSNPAdVisibility_FieldNumber_EpochOffset = 4,
  CSNPAdVisibility_FieldNumber_Duration = 5,
  CSNPAdVisibility_FieldNumber_ComponentVisibility = 6,
  CSNPAdVisibility_FieldNumber_ScreenVisibility = 7,
};

@interface CSNPAdVisibility : GPBMessage

@property(nonatomic, readwrite) uint64_t requestId;

@property(nonatomic, readwrite) uint64_t adId;

@property(nonatomic, readwrite) uint64_t componentId;

@property(nonatomic, readwrite) uint64_t epochOffset;

@property(nonatomic, readwrite) uint64_t duration;

@property(nonatomic, readwrite, strong, null_resettable) CSNPSimpleStat *componentVisibility;
/** Test to see if @c componentVisibility has been set. */
@property(nonatomic, readwrite) BOOL hasComponentVisibility;

@property(nonatomic, readwrite, strong, null_resettable) CSNPSimpleStat *screenVisibility;
/** Test to see if @c screenVisibility has been set. */
@property(nonatomic, readwrite) BOOL hasScreenVisibility;

@end

#pragma mark - CSNPAdInteraction

typedef GPB_ENUM(CSNPAdInteraction_FieldNumber) {
  CSNPAdInteraction_FieldNumber_RequestId = 1,
  CSNPAdInteraction_FieldNumber_AdId = 2,
  CSNPAdInteraction_FieldNumber_ComponentId = 3,
  CSNPAdInteraction_FieldNumber_Duration = 4,
  CSNPAdInteraction_FieldNumber_EpochOffset = 5,
  CSNPAdInteraction_FieldNumber_Kind = 6,
};

@interface CSNPAdInteraction : GPBMessage

@property(nonatomic, readwrite) uint64_t requestId;

@property(nonatomic, readwrite) uint64_t adId;

@property(nonatomic, readwrite) uint64_t componentId;

@property(nonatomic, readwrite) uint64_t duration;

@property(nonatomic, readwrite) uint64_t epochOffset;

@property(nonatomic, readwrite) CSNPAdInteractionKind kind;

@end

/**
 * Fetches the raw value of a @c CSNPAdInteraction's @c kind property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t CSNPAdInteraction_Kind_RawValue(CSNPAdInteraction *message);
/**
 * Sets the raw value of an @c CSNPAdInteraction's @c kind property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetCSNPAdInteraction_Kind_RawValue(CSNPAdInteraction *message, int32_t value);

#pragma mark - CSNPAdReport

typedef GPB_ENUM(CSNPAdReport_FieldNumber) {
  CSNPAdReport_FieldNumber_AdUnit = 1,
  CSNPAdReport_FieldNumber_DeviceId = 2,
  CSNPAdReport_FieldNumber_Timezone = 3,
  CSNPAdReport_FieldNumber_Epoch = 4,
  CSNPAdReport_FieldNumber_AdVisibiltyArray = 5,
  CSNPAdReport_FieldNumber_AdInteractionsArray = 6,
};

@interface CSNPAdReport : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *adUnit;

@property(nonatomic, readwrite, strong, null_resettable) CSNPDeviceID *deviceId;
/** Test to see if @c deviceId has been set. */
@property(nonatomic, readwrite) BOOL hasDeviceId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *timezone;

@property(nonatomic, readwrite) uint64_t epoch;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<CSNPAdVisibility*> *adVisibiltyArray;
/** The number of items in @c adVisibiltyArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger adVisibiltyArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<CSNPAdInteraction*> *adInteractionsArray;
/** The number of items in @c adInteractionsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger adInteractionsArray_Count;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
