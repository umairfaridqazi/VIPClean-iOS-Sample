//
//  DispatchQueue.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

extension DispatchQueue {
    private static var onceTracker = [String]()
    public class func once(token: String, block: () -> Void) {
        objc_sync_enter(self);
        defer {
            objc_sync_exit(self)
        }
        
        if onceTracker.contains(token) { return }
        onceTracker.append(token)
        block()
    }
}
