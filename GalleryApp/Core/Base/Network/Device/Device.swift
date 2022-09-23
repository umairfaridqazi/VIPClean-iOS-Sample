//
//  Device.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

struct ApplicationVersonConfigurationKeys {
    static let applicationVersion = "CFBundleShortVersionString"
    static let bundleVersion = "CFBundleVersion"
}

class Device: NSObject {
    // MARK: - Variables
    
    var deviceHeaders: [String: String]
    
    static var sharedManager = Device()
    
    // MARK: - Initilizers
    
    override init() {
        deviceHeaders = Dictionary()
        
        super.init()
        
        addUserNameHeader()
        // Add more here ....
    }
    
    // MARK: - Helper Methods
    
    private func addHeader(key: String, header: String) {
           deviceHeaders[key] = header
    }
    
    private func addUserNameHeader() {
        
        addHeader(key: DeviceHeaderField.deviceId, header: AccountManager.shared.deviceId)
        
    }
    
    /// This method will update the all needed device headers as per requirment
    func updateDeviceHeaders() {
        // call all headers helper method to upadte its value in 'deviceHeaders'
        addUserNameHeader()
        // Add more here ....
    }
}

extension Device {
    class func getApplicationVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary[ApplicationVersonConfigurationKeys.applicationVersion] as! String
        return "\(version)"
    }
    
    class func getApplicationBuildVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let build = dictionary[ApplicationVersonConfigurationKeys.bundleVersion] as! String
        return "\(build)"
    }
}

struct ScreenSize {
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType {
    static let IS_IPHONE_4_OR_LESS = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPHONE_XMax = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896
    static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    let IS_IPHONE = UIDevice.current.userInterfaceIdiom == .phone
    let IS_IPHONE_6_PLUS_ONWARDS = UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.bounds.size.height >= 736.0
    let IS_IPHONE_X_SERIES = UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.bounds.size.height >= 812.0
}

struct Version {
    static let SYS_VERSION_FLOAT = (UIDevice.current.systemVersion as NSString).floatValue
    static let iOS7 = (Version.SYS_VERSION_FLOAT < 8.0 && Version.SYS_VERSION_FLOAT >= 7.0)
    static let iOS8 = (Version.SYS_VERSION_FLOAT >= 8.0 && Version.SYS_VERSION_FLOAT < 9.0)
    static let iOS9 = (Version.SYS_VERSION_FLOAT >= 9.0 && Version.SYS_VERSION_FLOAT < 10.0)
    static let iOS10 = (Version.SYS_VERSION_FLOAT >= 10.0 && Version.SYS_VERSION_FLOAT < 11.0)
    static let iOS11 = (Version.SYS_VERSION_FLOAT >= 11.0 && Version.SYS_VERSION_FLOAT < 12.0)
}
