#import <Cordova/CDV.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface CellularInfo : CDVPlugin

- (void)getSimInfo:(CDVInvokedUrlCommand*)command;

@end
