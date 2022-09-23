//
//  BaseServiceUtils.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

class BaseServiceUtils: NSObject {
    class func baseUrlImplementedSSL() -> Bool {
        return Config.serverURL.lowercased().starts(with: "https")
    }
}
