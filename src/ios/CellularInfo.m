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

- (NSString *)getIP {

    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];

                }

            }

            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;

}

- (void) getIPAddress:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* ipaddr = [self getIP];

    if (ipaddr != nil && ![ipaddr isEqualToString:@"error"]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:ipaddr];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}




@end
