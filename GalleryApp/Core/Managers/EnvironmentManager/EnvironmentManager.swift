//
//  EnvironmentManager.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import Foundation
import UIKit

private enum PlistKey: String {
    case ServerURL = "ServerUrl"
    case LogEnabled = "isLogEnabled"
    case ConnectionProtocol = "Protocol"
}

private struct Plist {
    private var infoDict: [String: Any] {
        if let dict = Bundle.main.infoDictionary {
            return dict
        } else {
            fatalError("Plist file not found")
        }
    }

    public func configuration(_ key: PlistKey) -> String {
        switch key {
        case .ServerURL:
            return infoDict[PlistKey.ServerURL.rawValue] as? String ?? ""
        case .LogEnabled:
            return infoDict[PlistKey.LogEnabled.rawValue] as? String ?? "false"
        case .ConnectionProtocol:
            return infoDict[PlistKey.ConnectionProtocol.rawValue] as? String ?? ""
        }
    }
}

public struct Config {
    static let serverURL = Plist().configuration(PlistKey.ConnectionProtocol) + "://" + Plist().configuration(PlistKey.ServerURL) + "/"
    static let logEnabled = Plist().configuration(PlistKey.LogEnabled)
}

struct Environment {
    static func isDebug() -> Bool {
        #if DEBUG
        return true

        #else
        return false
        #endif
    }
}
