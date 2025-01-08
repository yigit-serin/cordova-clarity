import Foundation
import Clarity

@objc(ClarityPlugin)
class ClarityPlugin: CDVPlugin {
    
    @objc(initialize:)
    func initialize(command: CDVInvokedUrlCommand) {
        let projectId = command.arguments[0] as? String ?? ""
        let userId = command.arguments[1] as? String
        let logLevel = command.arguments[2] as? Int ?? 0
        let isIonic = command.arguments[7] as? Bool ?? false
        
        let clarityLogLevel: LogLevel = LogLevel(rawValue: logLevel) ?? .none
        let framework: ApplicationFramework = isIonic ? .ionic : .cordova
        
        let clarityConfig = ClarityConfig(
            projectId: projectId,
            userId: userId,
            logLevel: clarityLogLevel,
            applicationFramework: framework
        )
        
        if ClaritySDK.initialize(config: clarityConfig) {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Clarity initialized.")
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
        } else {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Failed to initialize Clarity, please check logs for more details!")
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
        }
    }
    
    @objc(pause:)
    func pause(command: CDVInvokedUrlCommand) {
        ClaritySDK.pause()
        if ClaritySDK.isPaused {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Clarity paused.")
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
        } else {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Failed to pause Clarity, please check logs for more details!")
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
        }
    }
    
    @objc(resume:)
    func resume(command: CDVInvokedUrlCommand) {
        ClaritySDK.resume()
        if !ClaritySDK.isPaused {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Resume succeeded.")
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
        } else {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Failed to resume Clarity, please check logs for more details!")
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
        }
    }
    
    @objc(isPaused:)
    func isPaused(command: CDVInvokedUrlCommand) {
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: ClaritySDK.isPaused ? 1 : 0)
        self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }
    
    @objc(setCustomUserId:)
    func setCustomUserId(command: CDVInvokedUrlCommand) {
        let customUserId = command.arguments[0] as? String
        
        if ClaritySDK.setCustomUserId(customUserId) {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Setting custom user id succeeded.")
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
        } else {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Setting custom user id failed, please check logs for more details!")
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
        }
    }
    
    @objc(setCustomSessionId:)
    func setCustomSessionId(command: CDVInvokedUrlCommand) {
        let customSessionId = command.arguments[0] as? String
        
        if ClaritySDK.setCustomSessionId(customSessionId) {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Setting custom session id succeeded.")
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
        } else {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Setting custom session id failed, please check logs for more details!")
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
        }
    }
    
    @objc(setCurrentScreenName:)
    func setCurrentScreenName(command: CDVInvokedUrlCommand) {
        let currentScreenName = command.arguments[0] as? String
        
        if ClaritySDK.setCurrentScreenName(currentScreenName) {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Setting custom screen name succeeded.")
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
        } else {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Setting custom screen name failed, please check logs for more details!")
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
        }
    }
    
    @objc(setCustomTag:)
    func setCustomTag(command: CDVInvokedUrlCommand) {
        let key = command.arguments[0] as? String
        let value = command.arguments[1] as? String
        
        if ClaritySDK.setCustomTag(key: key, value: value) {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Setting custom tag succeeded.")
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
        } else {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Setting custom tag failed, please check logs for more details!")
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
        }
    }
    
    @objc(getCurrentSessionId:)
    func getCurrentSessionId(command: CDVInvokedUrlCommand) {
        let sessionId = ClaritySDK.getCurrentSessionId()
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: sessionId)
        self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }
    
    @objc(getCurrentSessionUrl:)
    func getCurrentSessionUrl(command: CDVInvokedUrlCommand) {
        let sessionUrl = ClaritySDK.getCurrentSessionUrl()
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: sessionUrl)
        self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }
}
