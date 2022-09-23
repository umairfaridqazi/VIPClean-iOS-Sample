//
//  String.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import Foundation
import LocalAuthentication

extension UserDefaults {
    private enum Key: String {
        case languageCode = "LanguageCode"
        case regionCode = "RegionCode"
    }

    static var languageCode: String? {
        get {
            let defs = UserDefaults.standard
            return defs.string(forKey: Key.languageCode.rawValue)
        }
        set(value) {
            let defs = UserDefaults.standard
            if let value = value {
                defs.set(value, forKey: Key.languageCode.rawValue)
                return
            }
            defs.removeObject(forKey: Key.languageCode.rawValue)
        }
    }

    static var regionCode: String? {
        get {
            let defs = UserDefaults.standard
            return defs.string(forKey: Key.regionCode.rawValue)
        }
        set(value) {
            let defs = UserDefaults.standard
            if let value = value {
                defs.set(value, forKey: Key.regionCode.rawValue)
                return
            }
            defs.removeObject(forKey: Key.regionCode.rawValue)
        }
    }
}
