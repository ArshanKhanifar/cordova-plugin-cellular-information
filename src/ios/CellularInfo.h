#import <Cordova/CDV.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface CellularInfo : CDVPlugin

- (void)getCellularInfo:(CDVInvokedUrlCommand*)command;

@end
