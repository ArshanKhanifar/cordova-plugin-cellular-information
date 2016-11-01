// MCC and MNC codes on Wikipedia
// http://en.wikipedia.org/wiki/Mobile_country_code

// Mobile Network Codes (MNC) for the international identification plan for public networks and subscriptions
// http://www.itu.int/pub/T-SP-E.212B-2014

// class CTCarrier
// https://developer.apple.com/library/prerelease/ios/documentation/NetworkingInternet/Reference/CTCarrier/index.html

#import "CellularInfo.h"
#import <Cordova/CDV.h>
#import <Foundation/Foundation.h>

@implementation CellularInfo

- (void)getCellularInfo:(CDVInvokedUrlCommand*)command
{
  CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
  CTCarrier *carrier = [netinfo subscriberCellularProvider];

  BOOL allowsVOIPResult = [carrier allowsVOIP];
  NSString *carrierNameResult = [carrier carrierName];
  NSString *carrierCountryResult = [carrier isoCountryCode];
  NSString *carrierCodeResult = [carrier mobileCountryCode];
  NSString *carrierNetworkResult = [carrier mobileNetworkCode];

  if (!carrierNameResult) {
    carrierNameResult = @"";
  }
  if (!carrierCountryResult) {
    carrierCountryResult = @"";
  }
  if (!carrierCodeResult) {
    carrierCodeResult = @"";
  }
  if (!carrierNetworkResult) {
    carrierNetworkResult = @"";
  }

  NSDictionary *simData = [NSDictionary dictionaryWithObjectsAndKeys:
    @(allowsVOIPResult), @"Allows VOIP",
    carrierNameResult, @"Carrier Name",
    carrierCountryResult, @"Country Code",
    carrierCodeResult, @"MCC",
    carrierNetworkResult, @"MNC",
    nil];

  CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:simData];

  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (NSArray *)getIP {

    NSMutableArray *ipAddresses = [NSMutableArray array] ;

    struct ifaddrs *allInterfaces;

    // Get list of all interfaces on the local machine:
    if (getifaddrs(&allInterfaces) == 0) {
        struct ifaddrs *interface;

        // For each interface ...
        for (interface = allInterfaces; interface != NULL; interface = interface->ifa_next) {
            unsigned int flags = interface->ifa_flags;
            struct sockaddr *addr = interface->ifa_addr;

            // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
            if ((flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING)) {
                if (addr->sa_family == AF_INET || addr->sa_family == AF_INET6) {

                    // Convert interface address to a human readable string:
                    char host[NI_MAXHOST];
                    getnameinfo(addr, addr->sa_len, host, sizeof(host), NULL, 0, NI_NUMERICHOST);

                    [ipAddresses addObject:[[NSString alloc] initWithUTF8String:host]];
                }
            }
        }

        freeifaddrs(allInterfaces);
    }
    return ipAddresses;

}

- (void) getIPAddress:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSArray* ipaddr = [self getIP];

    if (ipaddr != nil) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:ipaddr];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}




@end
