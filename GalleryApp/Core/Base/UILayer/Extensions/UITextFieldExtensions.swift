//
//  UITextFieldExtension.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

extension UITextField {
//    @IBInspectable
//    var placeholderColor: UIColor? {
//        get {
//            return self.placeholderColor
//        }
//        set {
//            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: newValue ?? UIColor.white.withAlphaComponent(0.5)])
//        }
//    }
    
    public func placeholderColor(_ color: UIColor) {
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
      public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        if action == #selector(UIRespondeStandardEditActions.paste(_:)) {
//                return false
//            }
            return false
        }
}
