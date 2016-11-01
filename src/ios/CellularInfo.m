// MCC and MNC codes on Wikipedia
// http://en.wikipedia.org/wiki/Mobile_country_code

// Mobile Network Codes (MNC) for the international identification plan for public networks and subscriptions
// http://www.itu.int/pub/T-SP-E.212B-2014

// class CTCarrier
// https://developer.apple.com/library/prerelease/ios/documentation/NetworkingInternet/Reference/CTCarrier/index.html

#import "CellularInfo.h"
#import <Cordova/CDV.h>
#import <Foundation/Foundation.h>
#import "Message/NetworkController.h"

@implementation CellularInfo

- (void)getCellularInfo:(CDVInvokedUrlCommand*)command
{
  CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
  CTCarrier *carrier = [netinfo subscriberCellularProvider];
  NetworkController *ntc=[[NetworkController sharedInstance] autorelease];

  BOOL allowsVOIPResult = [carrier allowsVOIP];
  NSString *carrierNameResult = [carrier carrierName];
  NSString *carrierCountryResult = [carrier isoCountryCode];
  NSString *carrierCodeResult = [carrier mobileCountryCode];
  NSString *carrierNetworkResult = [carrier mobileNetworkCode];
  NSString *imeistring = [ntc IMEI];


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
  if (!imeistring) {
    imeistring = @"";
  }
  


  NSDictionary *simData = [NSDictionary dictionaryWithObjectsAndKeys:
    @(allowsVOIPResult), @"Allows VOIP",
    carrierNameResult, @"Carrier Name",
    carrierCountryResult, @"Country Code",
    carrierCodeResult, @"MCC",
    carrierNetworkResult, @"MNC",
    imeistring, "@IMEI",
    nil];

  CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:simData];

  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
