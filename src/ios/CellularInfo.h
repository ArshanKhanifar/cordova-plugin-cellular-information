#import <Cordova/CDV.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <Cordova/CDVPlugin.h>
#import <Cordova/CDVInvokedUrlCommand.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
@interface CellularInfo : CDVPlugin

- (void)getCellularInfo:(CDVInvokedUrlCommand*)command;

@end
