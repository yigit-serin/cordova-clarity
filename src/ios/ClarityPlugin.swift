import Foundation
import Clarity

@objc(ClarityPlugin)
class ClarityPlugin: CDVPlugin {
    
    @objc(initialize:)
    func initialize(command: CDVInvokedUrlCommand) {
        guard let projectId = command.arguments[0] as? String,
              let logLevel = command.arguments[2] as? Int else {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Invalid parameters")
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
            return
        }
        
        let clarityLogLevel: LogLevel = LogLevel(rawValue: logLevel) ?? .none
        let framework: ApplicationFramework = .cordova
        
        let clarityConfig = ClarityConfig(
            projectId: projectId,
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
        if ClaritySDK.isPaused() {
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
        if !ClaritySDK.isPaused() {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Resume succeeded.")
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
        } else {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Failed to resume Clarity, please check logs for more details!")
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
        }
    }
    
    @objc(isPaused:)
    func isPaused(command: CDVInvokedUrlCommand) {
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: ClaritySDK.isPaused() ? 1 : 0)
        self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }
    
    @objc(setCustomUserId:)
    func setCustomUserId(command: CDVInvokedUrlCommand) {
        guard let customUserId = command.arguments[0] as? String else {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Invalid custom user id")
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
            return
        }
        
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
        guard let customSessionId = command.arguments[0] as? String else {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Invalid custom session id")
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
            return
        }
        
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
        guard let currentScreenName = command.arguments[0] as? String else {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Invalid screen name")
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
            return
        }
        
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
        guard let key = command.arguments[0] as? String,
              let value = command.arguments[1] as? String else {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Invalid key or value")
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
            return
        }
        
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
