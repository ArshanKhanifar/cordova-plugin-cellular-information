#import <Cordova/CDV.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface CellularInformation : CDVPlugin

- (void)getCellularInformation:(CDVInvokedUrlCommand*)command;

@end
