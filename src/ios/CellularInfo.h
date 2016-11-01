#import <Cordova/CDV.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <Cordova/CDVPlugin.h>
#import <Cordova/CDVInvokedUrlCommand.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <ifaddrs.h>
#include <net/if.h>
#include <netdb.h>
@interface CellularInfo : CDVPlugin

- (void)getCellularInfo:(CDVInvokedUrlCommand*)command;

@end
