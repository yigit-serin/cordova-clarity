#import <Cordova/CDV.h>

@interface ClarityPlugin : CDVPlugin

- (void)initialize:(CDVInvokedUrlCommand*)command;
- (void)pause:(CDVInvokedUrlCommand*)command;
- (void)resume:(CDVInvokedUrlCommand*)command;
- (void)isPaused:(CDVInvokedUrlCommand*)command;
- (void)setCustomUserId:(CDVInvokedUrlCommand*)command;
- (void)setCustomSessionId:(CDVInvokedUrlCommand*)command;
- (void)setCurrentScreenName:(CDVInvokedUrlCommand*)command;
- (void)setCustomTag:(CDVInvokedUrlCommand*)command;
- (void)getCurrentSessionId:(CDVInvokedUrlCommand*)command;
- (void)getCurrentSessionUrl:(CDVInvokedUrlCommand*)command;

@end
