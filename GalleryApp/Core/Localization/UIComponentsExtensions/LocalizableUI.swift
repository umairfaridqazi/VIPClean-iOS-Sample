//
//  LocalizableUI.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

protocol LocalizableView: class {
    var localizedKey: String! { get set }
}

public protocol Localizable: class {
    /// The property that can be localized for each view, for example in a UILabel its the text, in a UIButton its the title, etc
    var localizableProperty: String? { get set }

    /// The localizable string value in the your localizable strings
    var localizableString: String { get set }

    /// Applies the localizable string to the supported view attribute
    func applyLocalizableString(_ localizableString: String?) -> Void
}

extension Localizable {
    /**
     Applies the localizable string to the supported view attribute

     - parameter localizableString: localizable String Value
     */
    public func applyLocalizableString(_ localizableString: String?) {
        self.localizableProperty = localizableString
    }
}

extension UIView: Localizable {
    /// Not implemented in base class
    @objc public var localizableProperty: String? {
        get {
            return ""
        }
        set {}
    }

    /// Applies the localizable string to the localizable field of the supported view
    @IBInspectable public var localizableString: String {
        get {
            guard let text = self.localizableProperty else {
                return ""
            }
            return text
        }
        set {
            /**
             *  Applys the localization to the property
             */
            applyLocalizableString(newValue)
            if self is LocalizableView {
                (self as! LocalizableView).localizedKey = newValue
            }
        }
    }

    // initializer for programatic use
    convenience init(_ localizableString: String, _ frame: CGRect) {
        self.init(frame: frame)
        self.localizableString = localizableString
    }
}

extension UIButton {
    public override var localizableProperty: String? {
        get {
            return self.currentTitle
        }
        set {
            self.setTitle(newValue, for: .normal)
        }
    }
}

extension UILabel {
    public override var localizableProperty: String? {
        get {
            return self.text
        }
        set {
            self.text = newValue
        }
    }
    
    public func forceTextAlignmentForHypridUILabelText(){
        let attributedString = NSMutableAttributedString(string: self.text ?? "")
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        // *** set setBaseWritingDirection property in points ***
            paragraphStyle.baseWritingDirection = .leftToRight
        
        // *** Apply attribute to string ***
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        // *** Set Attributed String to your label ***
        self.attributedText = attributedString
        
    }
}

extension UITextField {
    @objc public override var localizableProperty: String? {
        get {
            return self.placeholder
        }
        set {
            self.placeholder = newValue
        }
    }
}

extension UITextView {
    public override var localizableProperty: String? {
        get {
            return self.text
        }
        set {
            self.text = newValue
        }
    }
}

extension UISearchBar {
    @objc public override var localizableProperty: String? {
        get {
            return self.placeholder
        }
        set {
            self.placeholder = newValue
        }
    }
}

extension UIBarItem: Localizable {
    public var localizableProperty: String? {
        get {
            return self.title
        }
        set {
            self.title = newValue
        }
    }

    /// Applies the localizable string to the localizable field of the supported view
    @IBInspectable public var localizableString: String {
        get {
            guard let text = self.localizableProperty else {
                return ""
            }
            return text
        }
        set {
            applyLocalizableString(newValue)
            if self is LocalizableView {
                (self as! LocalizableView).localizedKey = newValue
            }
        }
    }
}

extension UINavigationItem: Localizable {
    public var localizableProperty: String? {
        get {
            return self.title
        }
        set {
            self.title = newValue
        }
    }

    /// Applies the localizable string to the localizable field of the supported view
    @IBInspectable public var localizableString: String {
        get {
            guard let text = self.localizableProperty else {
                return ""
            }
            return text
        }
        set {
            applyLocalizableString(newValue)
            if self is LocalizableView {
                (self as! LocalizableView).localizedKey = newValue
            }
        }
    }
}
//
//extension UICollectionViewFlowLayout {
//    
//    open override var flipsHorizontallyInOppositeLayoutDirection: Bool {
//        return true
//    }
//}
