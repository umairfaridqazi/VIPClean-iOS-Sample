//
//  UINavigationItem.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

extension UIBarItem {
    @IBInspectable
    public var localizedName: String {
        set {
            self.title = newValue//newValue.localiz()
        }

        get {
            return title ?? ""
        }
    }
}
