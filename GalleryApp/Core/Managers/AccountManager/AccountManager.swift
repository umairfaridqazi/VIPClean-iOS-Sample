//
//  AccountManager.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import Foundation
import UIKit

extension String {
    static let deviceIdKey = "device_id"
}

@objc class AccountManager: NSObject {

    @objc static var shared = AccountManager()
    
    private override init() {
        super.init()
        if deviceId.isEmpty {
            deviceId = UIDevice.current.identifierForVendor?.uuidString ?? "0000000000000000000000000000404"
        }
    }
    
    
    // User defaults
    var deviceId: String {
        get {
            if let deviceId = UserDefaults.standard.object(forKey: .deviceIdKey) as? String{
                return deviceId
            } else {
                return ""
            }
        }

        set(value) {
            UserDefaults.standard.set(value, forKey: .deviceIdKey)
        }
    }
    
}
