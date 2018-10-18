@import Foundation;
@import AdSupport;
#import "CSNClientInfo.h"

#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation CSNClientInfo

- (instancetype) initWithAdUnit:(NSUUID *)adUnit {
    _adUnit = adUnit;
    _deviceID = [self getDeviceID];
    _ipAddresses = [self getIpAddresses];
    _timeZone = [[NSTimeZone localTimeZone] name];
    return self;
}

- (CSNPDeviceID *) getDeviceID {
    ASIdentifierManager *adIdentManager = [ASIdentifierManager sharedManager];
    NSUUID *vendorID = [adIdentManager advertisingIdentifier];
    uuid_t vendorUUID;
    [vendorID getUUIDBytes:vendorUUID];
    NSData *deviceIDData = [[NSData alloc] initWithBytes:vendorUUID length:16];
    CSNPDeviceID *deviceID = [[CSNPDeviceID alloc] init];
    [deviceID setDeviceIdType:CSNPDeviceID_Type_Idfa];
    [deviceID setDeviceId:deviceIDData];
    [deviceID setLimitTracking:![adIdentManager isAdvertisingTrackingEnabled]];
    return deviceID;
}

- (void) updateDeviceID {
    _deviceID = [self getDeviceID];    
}

- (void) updateIpAddresses {
    _ipAddresses = [self getIpAddresses];
}

- (NSData *)getAdUnitData {
    uuid_t uuid;
    [_adUnit getUUIDBytes:uuid];
    return [NSData dataWithBytes:uuid length:16];
}

- (NSArray<NSData *> *) getIpAddresses {
    NSMutableArray *addrs = [[NSMutableArray alloc] init];
    struct ifaddrs *ifa, *ifa_tmp;
    
    if (getifaddrs(&ifa) == -1) {
        return addrs;
    }
    
    ifa_tmp = ifa;
    //char netaddr[INET6_ADDRSTRLEN];
    while (ifa_tmp) {
        if ((ifa_tmp->ifa_addr) && ((ifa_tmp->ifa_addr->sa_family == AF_INET) ||
                                    (ifa_tmp->ifa_addr->sa_family == AF_INET6))) {
            if (ifa_tmp->ifa_addr->sa_family == AF_INET) {
                // create IPv4 string
                struct sockaddr_in *in = (struct sockaddr_in*) ifa_tmp->ifa_addr;
                //inet_ntop(AF_INET, &in->sin_addr, netaddr, INET6_ADDRSTRLEN);
                if(in->sin_addr.s_addr != htonl(INADDR_LOOPBACK)) {
                    //NSLog(@"Ipv4 added %@", [NSString stringWithUTF8String:netaddr]);
                    NSData *addr = [NSData dataWithBytes:&in->sin_addr.s_addr length:4];
                    //NSLog(@"Ipv4 addr in NSData %@", [addr description]);
                    [addrs addObject:addr];
                }
            } else { // AF_INET6
                // create IPv6 string
                struct sockaddr_in6 *in6 = (struct sockaddr_in6*) ifa_tmp->ifa_addr;
                //inet_ntop(AF_INET6, &in6->sin6_addr, netaddr, INET6_ADDRSTRLEN);
                if(!IN6_IS_ADDR_LINKLOCAL(&in6->sin6_addr) && !IN6_IS_ADDR_LOOPBACK(&in6->sin6_addr)) {
                    //NSLog(@"Ipv6 added %@", [NSString stringWithUTF8String:netaddr]);
                    NSData *addr = [NSData dataWithBytes:in6->sin6_addr.s6_addr length:16];
                    //NSLog(@"Ipv6 addr in NSData %@", [addr description]);
                    [addrs addObject:addr];
                }
            }
        }
        ifa_tmp = ifa_tmp->ifa_next;
    }
    freeifaddrs(ifa);
    return addrs;
}

@end
