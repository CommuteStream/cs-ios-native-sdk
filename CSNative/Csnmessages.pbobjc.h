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

@class CSNAdInteraction;
@class CSNAdView;
@class CSNDeviceID;
@class CSNStop;
@class CSNStopAd;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum CSNAdInteractionKind

typedef GPB_ENUM(CSNAdInteractionKind) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  CSNAdInteractionKind_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  CSNAdInteractionKind_Tap = 0,
};

GPBEnumDescriptor *CSNAdInteractionKind_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL CSNAdInteractionKind_IsValidValue(int32_t value);

#pragma mark - Enum CSNDeviceID_Type

typedef GPB_ENUM(CSNDeviceID_Type) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  CSNDeviceID_Type_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  CSNDeviceID_Type_Idfa = 0,
  CSNDeviceID_Type_Aaid = 1,
};

GPBEnumDescriptor *CSNDeviceID_Type_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL CSNDeviceID_Type_IsValidValue(int32_t value);

#pragma mark - CSNCsnmessagesRoot

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
@interface CSNCsnmessagesRoot : GPBRootObject
@end

#pragma mark - CSNStop

typedef GPB_ENUM(CSNStop_FieldNumber) {
  CSNStop_FieldNumber_AgencyId = 1,
  CSNStop_FieldNumber_RouteId = 2,
  CSNStop_FieldNumber_StopId = 3,
};

@interface CSNStop : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *agencyId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *routeId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *stopId;

@end

#pragma mark - CSNStopAd

typedef GPB_ENUM(CSNStopAd_FieldNumber) {
  CSNStopAd_FieldNumber_RequestId = 1,
  CSNStopAd_FieldNumber_Stop = 2,
  CSNStopAd_FieldNumber_Icon = 3,
  CSNStopAd_FieldNumber_Title = 4,
  CSNStopAd_FieldNumber_BackgroundColor = 5,
};

@interface CSNStopAd : GPBMessage

@property(nonatomic, readwrite) uint64_t requestId;

@property(nonatomic, readwrite, strong, null_resettable) CSNStop *stop;
/** Test to see if @c stop has been set. */
@property(nonatomic, readwrite) BOOL hasStop;

@property(nonatomic, readwrite, copy, null_resettable) NSData *icon;

@property(nonatomic, readwrite, copy, null_resettable) NSString *title;

@property(nonatomic, readwrite, copy, null_resettable) NSString *backgroundColor;

@end

#pragma mark - CSNStopAdResponse

typedef GPB_ENUM(CSNStopAdResponse_FieldNumber) {
  CSNStopAdResponse_FieldNumber_StopAdsArray = 1,
};

@interface CSNStopAdResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<CSNStopAd*> *stopAdsArray;
/** The number of items in @c stopAdsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger stopAdsArray_Count;

@end

#pragma mark - CSNDeviceID

typedef GPB_ENUM(CSNDeviceID_FieldNumber) {
  CSNDeviceID_FieldNumber_DeviceIdType = 1,
  CSNDeviceID_FieldNumber_DeviceId = 2,
};

@interface CSNDeviceID : GPBMessage

@property(nonatomic, readwrite) CSNDeviceID_Type deviceIdType;

@property(nonatomic, readwrite, copy, null_resettable) NSString *deviceId;

@end

/**
 * Fetches the raw value of a @c CSNDeviceID's @c deviceIdType property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t CSNDeviceID_DeviceIdType_RawValue(CSNDeviceID *message);
/**
 * Sets the raw value of an @c CSNDeviceID's @c deviceIdType property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetCSNDeviceID_DeviceIdType_RawValue(CSNDeviceID *message, int32_t value);

#pragma mark - CSNStopAdRequest

typedef GPB_ENUM(CSNStopAdRequest_FieldNumber) {
  CSNStopAdRequest_FieldNumber_AdUnit = 1,
  CSNStopAdRequest_FieldNumber_DeviceId = 2,
  CSNStopAdRequest_FieldNumber_Timezone = 3,
  CSNStopAdRequest_FieldNumber_StopsArray = 4,
};

@interface CSNStopAdRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *adUnit;

@property(nonatomic, readwrite, strong, null_resettable) CSNDeviceID *deviceId;
/** Test to see if @c deviceId has been set. */
@property(nonatomic, readwrite) BOOL hasDeviceId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *timezone;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<CSNStop*> *stopsArray;
/** The number of items in @c stopsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger stopsArray_Count;

@end

#pragma mark - CSNAdView

typedef GPB_ENUM(CSNAdView_FieldNumber) {
  CSNAdView_FieldNumber_RequestId = 1,
  CSNAdView_FieldNumber_ComponentId = 2,
  CSNAdView_FieldNumber_Duration = 3,
  CSNAdView_FieldNumber_PercentVisible = 4,
};

@interface CSNAdView : GPBMessage

@property(nonatomic, readwrite) uint64_t requestId;

@property(nonatomic, readwrite) uint64_t componentId;

@property(nonatomic, readwrite) uint64_t duration;

@property(nonatomic, readwrite) double percentVisible;

@end

#pragma mark - CSNAdInteraction

typedef GPB_ENUM(CSNAdInteraction_FieldNumber) {
  CSNAdInteraction_FieldNumber_RequestId = 1,
  CSNAdInteraction_FieldNumber_ComponentId = 2,
  CSNAdInteraction_FieldNumber_Duration = 3,
  CSNAdInteraction_FieldNumber_Kind = 4,
};

@interface CSNAdInteraction : GPBMessage

@property(nonatomic, readwrite) uint64_t requestId;

@property(nonatomic, readwrite) uint64_t componentId;

@property(nonatomic, readwrite) uint64_t duration;

@property(nonatomic, readwrite) CSNAdInteractionKind kind;

@end

/**
 * Fetches the raw value of a @c CSNAdInteraction's @c kind property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t CSNAdInteraction_Kind_RawValue(CSNAdInteraction *message);
/**
 * Sets the raw value of an @c CSNAdInteraction's @c kind property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetCSNAdInteraction_Kind_RawValue(CSNAdInteraction *message, int32_t value);

#pragma mark - CSNAdReport

typedef GPB_ENUM(CSNAdReport_FieldNumber) {
  CSNAdReport_FieldNumber_AdUnit = 1,
  CSNAdReport_FieldNumber_DeviceId = 2,
  CSNAdReport_FieldNumber_Timezone = 3,
  CSNAdReport_FieldNumber_AdViewsArray = 4,
  CSNAdReport_FieldNumber_AdInteractionsArray = 5,
};

@interface CSNAdReport : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *adUnit;

@property(nonatomic, readwrite, strong, null_resettable) CSNDeviceID *deviceId;
/** Test to see if @c deviceId has been set. */
@property(nonatomic, readwrite) BOOL hasDeviceId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *timezone;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<CSNAdView*> *adViewsArray;
/** The number of items in @c adViewsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger adViewsArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<CSNAdInteraction*> *adInteractionsArray;
/** The number of items in @c adInteractionsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger adInteractionsArray_Count;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
