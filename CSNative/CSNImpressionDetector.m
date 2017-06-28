#import "CSNImpressionDetector.h"

@interface CSNImpressionCounter : NSObject
@property uint64_t totalVisible;
@property uint64_t lastImpressionTime;
@property uint64_t lastVisibleTime;
@end

@implementation CSNImpressionCounter

- (instancetype) init {
    _totalVisible = 0;
    _lastVisibleTime = 0;
    _lastImpressionTime = 0;
    return self;
}

@end

@interface CSNImpressionDetector ()
@property NSMutableDictionary* visibleCounters;
@property uint64_t maxSampleSkew;
@property uint64_t impressionTime;
@property uint64_t impressionDuration;
@property double impressionVisiblity;
@end

const uint64_t MAX_SAMPLE_SKEW = 1000;
const uint64_t IMPRESSION_TIME = 1000;
const uint64_t IMPRESSION_DURATION = 30000;
const double IMPRESSION_VISIBILITY = 0.5;

@implementation CSNImpressionDetector

- (instancetype) init {
    return [self initWithSampleSkew:MAX_SAMPLE_SKEW impressionTime:IMPRESSION_TIME impressionDuration:IMPRESSION_DURATION impressionVisibility:IMPRESSION_VISIBILITY];
}

- (instancetype) initWithSampleSkew:(uint64_t)sampleSkew impressionTime:(uint64_t)impressionTime impressionDuration:(uint64_t)impressionDuration impressionVisibility:(double)impressionVisibility {
    _visibleCounters = [[NSMutableDictionary alloc] init];
    _maxSampleSkew = sampleSkew;
    _impressionTime = impressionTime;
    _impressionDuration = impressionDuration;
    _impressionVisiblity = impressionVisibility;
    return self;
}

- (bool) recordVisibility:(uint64_t)requestID adID:(uint64_t)adID versionID:(uint64_t)versionID componentID:(uint64_t)componentID viewVisibility:(double)viewVisiblity deviceVisibility:(double)deviceVisibility {
    uint64_t time = [self currentTime];
    id objects[] = {
        [NSNumber numberWithUnsignedLongLong:requestID],
        [NSNumber numberWithUnsignedLongLong:adID],
        [NSNumber numberWithUnsignedLongLong:versionID]
    };
    NSArray *adKey = [NSArray arrayWithObjects:objects count:3];
    CSNImpressionCounter *impCounter = [_visibleCounters objectForKey:adKey];
    if(impCounter == nil) {
        impCounter = [[CSNImpressionCounter alloc] init];
        [_visibleCounters setObject:impCounter forKey:adKey];
    }
    if(viewVisiblity >= self.impressionVisiblity) {
        uint64_t visibleDiff = time - impCounter.lastVisibleTime;
        if(visibleDiff < self.maxSampleSkew) {
            impCounter.totalVisible += visibleDiff;
        } else {
            impCounter.totalVisible = 0;
        }
    } else {
        impCounter.totalVisible = 0;
    }
    impCounter.lastVisibleTime = time;
    if(impCounter.totalVisible > self.impressionTime && time - impCounter.lastImpressionTime > self.impressionDuration ) {
        impCounter.lastImpressionTime = time;
        return true;
    } else {
        return false;
    }
}


- (bool) recordInteraction:(uint64_t)requestID adID:(uint64_t)adID versionID:(uint64_t)versionID componentID:(uint64_t)componentID interactionKind:(int32_t)interactionKind {
    uint64_t time = [self currentTime];
    id objects[] = {
        [NSNumber numberWithUnsignedLongLong:requestID],
        [NSNumber numberWithUnsignedLongLong:adID],
        [NSNumber numberWithUnsignedLongLong:versionID]
    };
    NSArray *adKey = [NSArray arrayWithObjects:objects count:3];
    CSNImpressionCounter *impCounter = [_visibleCounters objectForKey:adKey];
    if(impCounter == nil) {
        impCounter = [[CSNImpressionCounter alloc] init];
        [_visibleCounters setObject:impCounter forKey:adKey];
    }
    if(time - impCounter.lastImpressionTime > self.impressionDuration) {
        impCounter.lastImpressionTime = time;
        return true;
    } else {
        return false;
    }
}

// return the current device time in milliseconds since the unix epoch
- (uint64_t) currentTime {
    return (uint64_t)([[NSDate date] timeIntervalSince1970] * 1000.0);
}

@end
