//
//  LogsManager.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

class LogsManager {
    class func verbose(_ items: Any) {
        #if !Production
        print(items)
        #endif
    }

    /// log something which help during debugging (low priority)
    class func debug(_ items: Any) {
        #if !Production
        print(items)
        #endif
    }

    /// log something which you are really interested but which is not an issue or error (normal priority)
    class func info(_ items: Any) {
        #if !Production
        print(items)
        #endif
    }

    /// log something which may cause big trouble soon (high priority)
    class func warning(_ items: Any) {
        #if !Production
        print(items)
        #endif
    }

    /// log something which will keep you awake at night (highest priority)
    class func error(_ items: Any) {
        #if !Production
        print(items)
        #endif
    }
}
