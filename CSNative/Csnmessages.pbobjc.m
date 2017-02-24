// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: csnmessages.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers_RuntimeSupport.h>
#else
 #import "GPBProtocolBuffers_RuntimeSupport.h"
#endif

 #import "Csnmessages.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - CSNCsnmessagesRoot

@implementation CSNCsnmessagesRoot

// No extensions in the file and no imports, so no need to generate
// +extensionRegistry.

@end

#pragma mark - CSNCsnmessagesRoot_FileDescriptor

static GPBFileDescriptor *CSNCsnmessagesRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"google.protobuf"
                                                 objcPrefix:@"CSN"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - Enum CSNAdInteractionKind

GPBEnumDescriptor *CSNAdInteractionKind_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "Tap\000";
    static const int32_t values[] = {
        CSNAdInteractionKind_Tap,
    };
    static const char *extraTextFormatInfo = "\001\000\003\000";
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(CSNAdInteractionKind)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:CSNAdInteractionKind_IsValidValue
                              extraTextFormatInfo:extraTextFormatInfo];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL CSNAdInteractionKind_IsValidValue(int32_t value__) {
  switch (value__) {
    case CSNAdInteractionKind_Tap:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - CSNStop

@implementation CSNStop

@dynamic agencyId;
@dynamic routeId;
@dynamic stopId;

typedef struct CSNStop__storage_ {
  uint32_t _has_storage_[1];
  NSString *agencyId;
  NSString *routeId;
  NSString *stopId;
} CSNStop__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "agencyId",
        .dataTypeSpecific.className = NULL,
        .number = CSNStop_FieldNumber_AgencyId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(CSNStop__storage_, agencyId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "routeId",
        .dataTypeSpecific.className = NULL,
        .number = CSNStop_FieldNumber_RouteId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(CSNStop__storage_, routeId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "stopId",
        .dataTypeSpecific.className = NULL,
        .number = CSNStop_FieldNumber_StopId,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(CSNStop__storage_, stopId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[CSNStop class]
                                     rootClass:[CSNCsnmessagesRoot class]
                                          file:CSNCsnmessagesRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(CSNStop__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - CSNStopAd

@implementation CSNStopAd

@dynamic requestId;
@dynamic hasStop, stop;
@dynamic icon;
@dynamic title;
@dynamic backgroundColor;

typedef struct CSNStopAd__storage_ {
  uint32_t _has_storage_[1];
  CSNStop *stop;
  NSData *icon;
  NSString *title;
  NSString *backgroundColor;
  uint64_t requestId;
} CSNStopAd__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "requestId",
        .dataTypeSpecific.className = NULL,
        .number = CSNStopAd_FieldNumber_RequestId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(CSNStopAd__storage_, requestId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "stop",
        .dataTypeSpecific.className = GPBStringifySymbol(CSNStop),
        .number = CSNStopAd_FieldNumber_Stop,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(CSNStopAd__storage_, stop),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "icon",
        .dataTypeSpecific.className = NULL,
        .number = CSNStopAd_FieldNumber_Icon,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(CSNStopAd__storage_, icon),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBytes,
      },
      {
        .name = "title",
        .dataTypeSpecific.className = NULL,
        .number = CSNStopAd_FieldNumber_Title,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(CSNStopAd__storage_, title),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "backgroundColor",
        .dataTypeSpecific.className = NULL,
        .number = CSNStopAd_FieldNumber_BackgroundColor,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(CSNStopAd__storage_, backgroundColor),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[CSNStopAd class]
                                     rootClass:[CSNCsnmessagesRoot class]
                                          file:CSNCsnmessagesRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(CSNStopAd__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - CSNStopAdResponse

@implementation CSNStopAdResponse

@dynamic stopAdsArray, stopAdsArray_Count;

typedef struct CSNStopAdResponse__storage_ {
  uint32_t _has_storage_[1];
  NSMutableArray *stopAdsArray;
} CSNStopAdResponse__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "stopAdsArray",
        .dataTypeSpecific.className = GPBStringifySymbol(CSNStopAd),
        .number = CSNStopAdResponse_FieldNumber_StopAdsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(CSNStopAdResponse__storage_, stopAdsArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[CSNStopAdResponse class]
                                     rootClass:[CSNCsnmessagesRoot class]
                                          file:CSNCsnmessagesRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(CSNStopAdResponse__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - CSNDeviceID

@implementation CSNDeviceID

@dynamic deviceIdType;
@dynamic deviceId;

typedef struct CSNDeviceID__storage_ {
  uint32_t _has_storage_[1];
  CSNDeviceID_Type deviceIdType;
  NSString *deviceId;
} CSNDeviceID__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "deviceIdType",
        .dataTypeSpecific.enumDescFunc = CSNDeviceID_Type_EnumDescriptor,
        .number = CSNDeviceID_FieldNumber_DeviceIdType,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(CSNDeviceID__storage_, deviceIdType),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor),
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "deviceId",
        .dataTypeSpecific.className = NULL,
        .number = CSNDeviceID_FieldNumber_DeviceId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(CSNDeviceID__storage_, deviceId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[CSNDeviceID class]
                                     rootClass:[CSNCsnmessagesRoot class]
                                          file:CSNCsnmessagesRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(CSNDeviceID__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t CSNDeviceID_DeviceIdType_RawValue(CSNDeviceID *message) {
  GPBDescriptor *descriptor = [CSNDeviceID descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:CSNDeviceID_FieldNumber_DeviceIdType];
  return GPBGetMessageInt32Field(message, field);
}

void SetCSNDeviceID_DeviceIdType_RawValue(CSNDeviceID *message, int32_t value) {
  GPBDescriptor *descriptor = [CSNDeviceID descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:CSNDeviceID_FieldNumber_DeviceIdType];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

#pragma mark - Enum CSNDeviceID_Type

GPBEnumDescriptor *CSNDeviceID_Type_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "Idfa\000Aaid\000";
    static const int32_t values[] = {
        CSNDeviceID_Type_Idfa,
        CSNDeviceID_Type_Aaid,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(CSNDeviceID_Type)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:CSNDeviceID_Type_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL CSNDeviceID_Type_IsValidValue(int32_t value__) {
  switch (value__) {
    case CSNDeviceID_Type_Idfa:
    case CSNDeviceID_Type_Aaid:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - CSNStopAdRequest

@implementation CSNStopAdRequest

@dynamic adUnit;
@dynamic hasDeviceId, deviceId;
@dynamic timezone;
@dynamic stopsArray, stopsArray_Count;

typedef struct CSNStopAdRequest__storage_ {
  uint32_t _has_storage_[1];
  NSString *adUnit;
  CSNDeviceID *deviceId;
  NSString *timezone;
  NSMutableArray *stopsArray;
} CSNStopAdRequest__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "adUnit",
        .dataTypeSpecific.className = NULL,
        .number = CSNStopAdRequest_FieldNumber_AdUnit,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(CSNStopAdRequest__storage_, adUnit),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "deviceId",
        .dataTypeSpecific.className = GPBStringifySymbol(CSNDeviceID),
        .number = CSNStopAdRequest_FieldNumber_DeviceId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(CSNStopAdRequest__storage_, deviceId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "timezone",
        .dataTypeSpecific.className = NULL,
        .number = CSNStopAdRequest_FieldNumber_Timezone,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(CSNStopAdRequest__storage_, timezone),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "stopsArray",
        .dataTypeSpecific.className = GPBStringifySymbol(CSNStop),
        .number = CSNStopAdRequest_FieldNumber_StopsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(CSNStopAdRequest__storage_, stopsArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[CSNStopAdRequest class]
                                     rootClass:[CSNCsnmessagesRoot class]
                                          file:CSNCsnmessagesRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(CSNStopAdRequest__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - CSNAdView

@implementation CSNAdView

@dynamic requestId;
@dynamic componentId;
@dynamic duration;
@dynamic percentVisible;

typedef struct CSNAdView__storage_ {
  uint32_t _has_storage_[1];
  uint64_t requestId;
  uint64_t componentId;
  uint64_t duration;
  double percentVisible;
} CSNAdView__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "requestId",
        .dataTypeSpecific.className = NULL,
        .number = CSNAdView_FieldNumber_RequestId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(CSNAdView__storage_, requestId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "componentId",
        .dataTypeSpecific.className = NULL,
        .number = CSNAdView_FieldNumber_ComponentId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(CSNAdView__storage_, componentId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "duration",
        .dataTypeSpecific.className = NULL,
        .number = CSNAdView_FieldNumber_Duration,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(CSNAdView__storage_, duration),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "percentVisible",
        .dataTypeSpecific.className = NULL,
        .number = CSNAdView_FieldNumber_PercentVisible,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(CSNAdView__storage_, percentVisible),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeDouble,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[CSNAdView class]
                                     rootClass:[CSNCsnmessagesRoot class]
                                          file:CSNCsnmessagesRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(CSNAdView__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - CSNAdInteraction

@implementation CSNAdInteraction

@dynamic requestId;
@dynamic componentId;
@dynamic duration;
@dynamic kind;

typedef struct CSNAdInteraction__storage_ {
  uint32_t _has_storage_[1];
  CSNAdInteractionKind kind;
  uint64_t requestId;
  uint64_t componentId;
  uint64_t duration;
} CSNAdInteraction__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "requestId",
        .dataTypeSpecific.className = NULL,
        .number = CSNAdInteraction_FieldNumber_RequestId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(CSNAdInteraction__storage_, requestId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "componentId",
        .dataTypeSpecific.className = NULL,
        .number = CSNAdInteraction_FieldNumber_ComponentId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(CSNAdInteraction__storage_, componentId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "duration",
        .dataTypeSpecific.className = NULL,
        .number = CSNAdInteraction_FieldNumber_Duration,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(CSNAdInteraction__storage_, duration),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "kind",
        .dataTypeSpecific.enumDescFunc = CSNAdInteractionKind_EnumDescriptor,
        .number = CSNAdInteraction_FieldNumber_Kind,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(CSNAdInteraction__storage_, kind),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor),
        .dataType = GPBDataTypeEnum,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[CSNAdInteraction class]
                                     rootClass:[CSNCsnmessagesRoot class]
                                          file:CSNCsnmessagesRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(CSNAdInteraction__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t CSNAdInteraction_Kind_RawValue(CSNAdInteraction *message) {
  GPBDescriptor *descriptor = [CSNAdInteraction descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:CSNAdInteraction_FieldNumber_Kind];
  return GPBGetMessageInt32Field(message, field);
}

void SetCSNAdInteraction_Kind_RawValue(CSNAdInteraction *message, int32_t value) {
  GPBDescriptor *descriptor = [CSNAdInteraction descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:CSNAdInteraction_FieldNumber_Kind];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

#pragma mark - CSNAdReport

@implementation CSNAdReport

@dynamic adUnit;
@dynamic hasDeviceId, deviceId;
@dynamic timezone;
@dynamic adViewsArray, adViewsArray_Count;
@dynamic adInteractionsArray, adInteractionsArray_Count;

typedef struct CSNAdReport__storage_ {
  uint32_t _has_storage_[1];
  NSString *adUnit;
  CSNDeviceID *deviceId;
  NSString *timezone;
  NSMutableArray *adViewsArray;
  NSMutableArray *adInteractionsArray;
} CSNAdReport__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "adUnit",
        .dataTypeSpecific.className = NULL,
        .number = CSNAdReport_FieldNumber_AdUnit,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(CSNAdReport__storage_, adUnit),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "deviceId",
        .dataTypeSpecific.className = GPBStringifySymbol(CSNDeviceID),
        .number = CSNAdReport_FieldNumber_DeviceId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(CSNAdReport__storage_, deviceId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "timezone",
        .dataTypeSpecific.className = NULL,
        .number = CSNAdReport_FieldNumber_Timezone,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(CSNAdReport__storage_, timezone),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "adViewsArray",
        .dataTypeSpecific.className = GPBStringifySymbol(CSNAdView),
        .number = CSNAdReport_FieldNumber_AdViewsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(CSNAdReport__storage_, adViewsArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "adInteractionsArray",
        .dataTypeSpecific.className = GPBStringifySymbol(CSNAdInteraction),
        .number = CSNAdReport_FieldNumber_AdInteractionsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(CSNAdReport__storage_, adInteractionsArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[CSNAdReport class]
                                     rootClass:[CSNCsnmessagesRoot class]
                                          file:CSNCsnmessagesRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(CSNAdReport__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
