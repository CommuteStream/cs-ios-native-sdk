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
@class CSNPAdImpression;
@class CSNPAdReport;
@class CSNPAdRequest;
@class CSNPAdResponse;
@class CSNPAdvertiserComponent;
@class CSNPBodyComponent;
@class CSNPColor;
@class CSNPColors;
@class CSNPComponentInteraction;
@class CSNPComponentReport;
@class CSNPDeviceID;
@class CSNPHeadlineComponent;
@class CSNPHeroComponent;
@class CSNPLocation;
@class CSNPLocationComponent;
@class CSNPLogoComponent;
@class CSNPNativeAd;
@class CSNPSecondaryActionComponent;
@class CSNPTransitAgency;
@class CSNPTransitRoute;
@class CSNPTransitStop;
@class CSNPViewComponent;

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

#pragma mark - Enum CSNPComponentInteractionKind

typedef GPB_ENUM(CSNPComponentInteractionKind) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  CSNPComponentInteractionKind_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  CSNPComponentInteractionKind_Tap = 0,
};

GPBEnumDescriptor *CSNPComponentInteractionKind_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL CSNPComponentInteractionKind_IsValidValue(int32_t value);

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

#pragma mark - CSNPTransitAgency

typedef GPB_ENUM(CSNPTransitAgency_FieldNumber) {
  CSNPTransitAgency_FieldNumber_AgencyId = 1,
};

@interface CSNPTransitAgency : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *agencyId;

@end

#pragma mark - CSNPTransitRoute

typedef GPB_ENUM(CSNPTransitRoute_FieldNumber) {
  CSNPTransitRoute_FieldNumber_AgencyId = 1,
  CSNPTransitRoute_FieldNumber_RouteId = 2,
};

@interface CSNPTransitRoute : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *agencyId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *routeId;

@end

#pragma mark - CSNPTransitStop

typedef GPB_ENUM(CSNPTransitStop_FieldNumber) {
  CSNPTransitStop_FieldNumber_AgencyId = 1,
  CSNPTransitStop_FieldNumber_RouteId = 2,
  CSNPTransitStop_FieldNumber_StopId = 3,
};

@interface CSNPTransitStop : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *agencyId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *routeId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *stopId;

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
  CSNPActionComponent_FieldNumber_Title = 4,
  CSNPActionComponent_FieldNumber_Colors = 5,
};

@interface CSNPActionComponent : GPBMessage

@property(nonatomic, readwrite) uint64_t componentId;

@property(nonatomic, readwrite) CSNPActionKind kind;

@property(nonatomic, readwrite, copy, null_resettable) NSString *URL;

@property(nonatomic, readwrite, copy, null_resettable) NSString *title;

@property(nonatomic, readwrite, strong, null_resettable) CSNPColors *colors;
/** Test to see if @c colors has been set. */
@property(nonatomic, readwrite) BOOL hasColors;

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

#pragma mark - CSNPLogoComponent

typedef GPB_ENUM(CSNPLogoComponent_FieldNumber) {
  CSNPLogoComponent_FieldNumber_ComponentId = 1,
  CSNPLogoComponent_FieldNumber_Image = 2,
};

@interface CSNPLogoComponent : GPBMessage

@property(nonatomic, readwrite) uint64_t componentId;

@property(nonatomic, readwrite, copy, null_resettable) NSData *image;

@end

#pragma mark - CSNPHeadlineComponent

typedef GPB_ENUM(CSNPHeadlineComponent_FieldNumber) {
  CSNPHeadlineComponent_FieldNumber_ComponentId = 1,
  CSNPHeadlineComponent_FieldNumber_Headline = 2,
};

@interface CSNPHeadlineComponent : GPBMessage

@property(nonatomic, readwrite) uint64_t componentId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *headline;

@end

#pragma mark - CSNPBodyComponent

typedef GPB_ENUM(CSNPBodyComponent_FieldNumber) {
  CSNPBodyComponent_FieldNumber_ComponentId = 1,
  CSNPBodyComponent_FieldNumber_Body = 2,
};

@interface CSNPBodyComponent : GPBMessage

@property(nonatomic, readwrite) uint64_t componentId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *body;

@end

#pragma mark - CSNPAdvertiserComponent

typedef GPB_ENUM(CSNPAdvertiserComponent_FieldNumber) {
  CSNPAdvertiserComponent_FieldNumber_ComponentId = 1,
  CSNPAdvertiserComponent_FieldNumber_Advertiser = 2,
};

@interface CSNPAdvertiserComponent : GPBMessage

@property(nonatomic, readwrite) uint64_t componentId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *advertiser;

@end

#pragma mark - CSNPColor

typedef GPB_ENUM(CSNPColor_FieldNumber) {
  CSNPColor_FieldNumber_Red = 1,
  CSNPColor_FieldNumber_Green = 2,
  CSNPColor_FieldNumber_Blue = 3,
};

@interface CSNPColor : GPBMessage

@property(nonatomic, readwrite) uint32_t red;

@property(nonatomic, readwrite) uint32_t green;

@property(nonatomic, readwrite) uint32_t blue;

@end

#pragma mark - CSNPColors

typedef GPB_ENUM(CSNPColors_FieldNumber) {
  CSNPColors_FieldNumber_Background = 1,
  CSNPColors_FieldNumber_Foreground = 2,
};

@interface CSNPColors : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) CSNPColor *background;
/** Test to see if @c background has been set. */
@property(nonatomic, readwrite) BOOL hasBackground;

@property(nonatomic, readwrite, strong, null_resettable) CSNPColor *foreground;
/** Test to see if @c foreground has been set. */
@property(nonatomic, readwrite) BOOL hasForeground;

@end

#pragma mark - CSNPSecondaryActionComponent

typedef GPB_ENUM(CSNPSecondaryActionComponent_FieldNumber) {
  CSNPSecondaryActionComponent_FieldNumber_ComponentId = 1,
  CSNPSecondaryActionComponent_FieldNumber_Title = 2,
  CSNPSecondaryActionComponent_FieldNumber_Subtitle = 3,
};

@interface CSNPSecondaryActionComponent : GPBMessage

@property(nonatomic, readwrite) uint64_t componentId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *title;

@property(nonatomic, readwrite, copy, null_resettable) NSString *subtitle;

@end

#pragma mark - CSNPViewComponent

typedef GPB_ENUM(CSNPViewComponent_FieldNumber) {
  CSNPViewComponent_FieldNumber_ComponentId = 1,
};

@interface CSNPViewComponent : GPBMessage

@property(nonatomic, readwrite) uint64_t componentId;

@end

#pragma mark - CSNPNativeAd

typedef GPB_ENUM(CSNPNativeAd_FieldNumber) {
  CSNPNativeAd_FieldNumber_RequestId = 1,
  CSNPNativeAd_FieldNumber_AdId = 2,
  CSNPNativeAd_FieldNumber_VersionId = 3,
  CSNPNativeAd_FieldNumber_Colors = 4,
  CSNPNativeAd_FieldNumber_ActionsArray = 5,
  CSNPNativeAd_FieldNumber_View = 6,
  CSNPNativeAd_FieldNumber_SecondaryActionScreen = 7,
  CSNPNativeAd_FieldNumber_Logo = 8,
  CSNPNativeAd_FieldNumber_Headline = 9,
  CSNPNativeAd_FieldNumber_Body = 10,
  CSNPNativeAd_FieldNumber_Advertiser = 11,
  CSNPNativeAd_FieldNumber_Location = 12,
  CSNPNativeAd_FieldNumber_Hero = 13,
};

@interface CSNPNativeAd : GPBMessage

@property(nonatomic, readwrite) uint64_t requestId;

@property(nonatomic, readwrite) uint64_t adId;

@property(nonatomic, readwrite) uint64_t versionId;

@property(nonatomic, readwrite, strong, null_resettable) CSNPColors *colors;
/** Test to see if @c colors has been set. */
@property(nonatomic, readwrite) BOOL hasColors;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<CSNPActionComponent*> *actionsArray;
/** The number of items in @c actionsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger actionsArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) CSNPViewComponent *view;
/** Test to see if @c view has been set. */
@property(nonatomic, readwrite) BOOL hasView;

@property(nonatomic, readwrite, strong, null_resettable) CSNPSecondaryActionComponent *secondaryActionScreen;
/** Test to see if @c secondaryActionScreen has been set. */
@property(nonatomic, readwrite) BOOL hasSecondaryActionScreen;

@property(nonatomic, readwrite, strong, null_resettable) CSNPLogoComponent *logo;
/** Test to see if @c logo has been set. */
@property(nonatomic, readwrite) BOOL hasLogo;

@property(nonatomic, readwrite, strong, null_resettable) CSNPHeadlineComponent *headline;
/** Test to see if @c headline has been set. */
@property(nonatomic, readwrite) BOOL hasHeadline;

@property(nonatomic, readwrite, strong, null_resettable) CSNPBodyComponent *body;
/** Test to see if @c body has been set. */
@property(nonatomic, readwrite) BOOL hasBody;

@property(nonatomic, readwrite, strong, null_resettable) CSNPAdvertiserComponent *advertiser;
/** Test to see if @c advertiser has been set. */
@property(nonatomic, readwrite) BOOL hasAdvertiser;

@property(nonatomic, readwrite, strong, null_resettable) CSNPLocationComponent *location;
/** Test to see if @c location has been set. */
@property(nonatomic, readwrite) BOOL hasLocation;

@property(nonatomic, readwrite, strong, null_resettable) CSNPHeroComponent *hero;
/** Test to see if @c hero has been set. */
@property(nonatomic, readwrite) BOOL hasHero;

@end

#pragma mark - CSNPAdRequest

typedef GPB_ENUM(CSNPAdRequest_FieldNumber) {
  CSNPAdRequest_FieldNumber_HashId = 1,
  CSNPAdRequest_FieldNumber_NumOfAds = 2,
  CSNPAdRequest_FieldNumber_LocationsArray = 3,
  CSNPAdRequest_FieldNumber_AgenciesArray = 4,
  CSNPAdRequest_FieldNumber_RoutesArray = 5,
  CSNPAdRequest_FieldNumber_StopsArray = 6,
};

/**
 * AdRequest contains a hash_id which is the hash everything but the num_of_ads
 **/
@interface CSNPAdRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSData *hashId;

@property(nonatomic, readwrite) uint32_t numOfAds;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<CSNPLocation*> *locationsArray;
/** The number of items in @c locationsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger locationsArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<CSNPTransitAgency*> *agenciesArray;
/** The number of items in @c agenciesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger agenciesArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<CSNPTransitRoute*> *routesArray;
/** The number of items in @c routesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger routesArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<CSNPTransitStop*> *stopsArray;
/** The number of items in @c stopsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger stopsArray_Count;

@end

#pragma mark - CSNPAdRequests

typedef GPB_ENUM(CSNPAdRequests_FieldNumber) {
  CSNPAdRequests_FieldNumber_AdUnit = 1,
  CSNPAdRequests_FieldNumber_DeviceId = 2,
  CSNPAdRequests_FieldNumber_IpAddressesArray = 3,
  CSNPAdRequests_FieldNumber_Timezone = 4,
  CSNPAdRequests_FieldNumber_AdRequestsArray = 5,
};

/**
 * AdRequests contains relevant information needed to attempt filling ad requests
 **/
@interface CSNPAdRequests : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSData *adUnit;

@property(nonatomic, readwrite, strong, null_resettable) CSNPDeviceID *deviceId;
/** Test to see if @c deviceId has been set. */
@property(nonatomic, readwrite) BOOL hasDeviceId;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSData*> *ipAddressesArray;
/** The number of items in @c ipAddressesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger ipAddressesArray_Count;

@property(nonatomic, readwrite, copy, null_resettable) NSString *timezone;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<CSNPAdRequest*> *adRequestsArray;
/** The number of items in @c adRequestsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger adRequestsArray_Count;

@end

#pragma mark - CSNPAdResponse

typedef GPB_ENUM(CSNPAdResponse_FieldNumber) {
  CSNPAdResponse_FieldNumber_HashId = 1,
  CSNPAdResponse_FieldNumber_AdsArray = 2,
};

/**
 * AdResponse is a mapping between an AdRequest hash_id and the set of ads
 **/
@interface CSNPAdResponse : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSData *hashId;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<CSNPNativeAd*> *adsArray;
/** The number of items in @c adsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger adsArray_Count;

@end

#pragma mark - CSNPAdResponses

typedef GPB_ENUM(CSNPAdResponses_FieldNumber) {
  CSNPAdResponses_FieldNumber_ServerId = 1,
  CSNPAdResponses_FieldNumber_AdResponsesArray = 2,
};

/**
 * AdResponses returns a mapping of ad context hashes to a set of ads.
 **/
@interface CSNPAdResponses : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *serverId;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<CSNPAdResponse*> *adResponsesArray;
/** The number of items in @c adResponsesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger adResponsesArray_Count;

@end

#pragma mark - CSNPDeviceID

typedef GPB_ENUM(CSNPDeviceID_FieldNumber) {
  CSNPDeviceID_FieldNumber_DeviceIdType = 1,
  CSNPDeviceID_FieldNumber_DeviceId = 2,
};

@interface CSNPDeviceID : GPBMessage

@property(nonatomic, readwrite) CSNPDeviceID_Type deviceIdType;

@property(nonatomic, readwrite, copy, null_resettable) NSData *deviceId;

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

#pragma mark - CSNPComponentInteraction

typedef GPB_ENUM(CSNPComponentInteraction_FieldNumber) {
  CSNPComponentInteraction_FieldNumber_DeviceTime = 1,
  CSNPComponentInteraction_FieldNumber_Kind = 2,
};

@interface CSNPComponentInteraction : GPBMessage

@property(nonatomic, readwrite) uint64_t deviceTime;

@property(nonatomic, readwrite) CSNPComponentInteractionKind kind;

@end

/**
 * Fetches the raw value of a @c CSNPComponentInteraction's @c kind property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t CSNPComponentInteraction_Kind_RawValue(CSNPComponentInteraction *message);
/**
 * Sets the raw value of an @c CSNPComponentInteraction's @c kind property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetCSNPComponentInteraction_Kind_RawValue(CSNPComponentInteraction *message, int32_t value);

#pragma mark - CSNPComponentReport

typedef GPB_ENUM(CSNPComponentReport_FieldNumber) {
  CSNPComponentReport_FieldNumber_ComponentId = 1,
  CSNPComponentReport_FieldNumber_VisibilityEpoch = 2,
  CSNPComponentReport_FieldNumber_VisibilitySampleCount = 3,
  CSNPComponentReport_FieldNumber_ViewVisibilitySamplesArray = 4,
  CSNPComponentReport_FieldNumber_DeviceVisibilitySamplesArray = 5,
  CSNPComponentReport_FieldNumber_InteractionsArray = 6,
};

@interface CSNPComponentReport : GPBMessage

@property(nonatomic, readwrite) uint64_t componentId;

@property(nonatomic, readwrite) uint64_t visibilityEpoch;

@property(nonatomic, readwrite) uint64_t visibilitySampleCount;

@property(nonatomic, readwrite, strong, null_resettable) GPBUInt64Array *viewVisibilitySamplesArray;
/** The number of items in @c viewVisibilitySamplesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger viewVisibilitySamplesArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) GPBUInt64Array *deviceVisibilitySamplesArray;
/** The number of items in @c deviceVisibilitySamplesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger deviceVisibilitySamplesArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<CSNPComponentInteraction*> *interactionsArray;
/** The number of items in @c interactionsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger interactionsArray_Count;

@end

#pragma mark - CSNPAdImpression

typedef GPB_ENUM(CSNPAdImpression_FieldNumber) {
  CSNPAdImpression_FieldNumber_DeviceTime = 1,
};

@interface CSNPAdImpression : GPBMessage

@property(nonatomic, readwrite) uint64_t deviceTime;

@end

#pragma mark - CSNPAdReport

typedef GPB_ENUM(CSNPAdReport_FieldNumber) {
  CSNPAdReport_FieldNumber_RequestId = 1,
  CSNPAdReport_FieldNumber_AdId = 2,
  CSNPAdReport_FieldNumber_VersionId = 3,
  CSNPAdReport_FieldNumber_ComponentsArray = 4,
  CSNPAdReport_FieldNumber_ImpressionsArray = 5,
};

@interface CSNPAdReport : GPBMessage

@property(nonatomic, readwrite) uint64_t requestId;

@property(nonatomic, readwrite) uint64_t adId;

@property(nonatomic, readwrite) uint64_t versionId;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<CSNPComponentReport*> *componentsArray;
/** The number of items in @c componentsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger componentsArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<CSNPAdImpression*> *impressionsArray;
/** The number of items in @c impressionsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger impressionsArray_Count;

@end

#pragma mark - CSNPAdReports

typedef GPB_ENUM(CSNPAdReports_FieldNumber) {
  CSNPAdReports_FieldNumber_AdUnit = 1,
  CSNPAdReports_FieldNumber_DeviceId = 2,
  CSNPAdReports_FieldNumber_Timezone = 3,
  CSNPAdReports_FieldNumber_IpAddressesArray = 4,
  CSNPAdReports_FieldNumber_DeviceTime = 5,
  CSNPAdReports_FieldNumber_AdReportsArray = 6,
};

@interface CSNPAdReports : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSData *adUnit;

@property(nonatomic, readwrite, strong, null_resettable) CSNPDeviceID *deviceId;
/** Test to see if @c deviceId has been set. */
@property(nonatomic, readwrite) BOOL hasDeviceId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *timezone;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSData*> *ipAddressesArray;
/** The number of items in @c ipAddressesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger ipAddressesArray_Count;

@property(nonatomic, readwrite) uint64_t deviceTime;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<CSNPAdReport*> *adReportsArray;
/** The number of items in @c adReportsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger adReportsArray_Count;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
