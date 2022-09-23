//
//  Colors.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

@objc extension UIColor {
    class func appErrorColor() -> UIColor { return UIColor(hex: "#A72207") }
    
    //    Navigation
    class func appNavigationDefaultForegroundColor() -> UIColor { return UIColor(hex: "ABFFDF") }
    class func appNavigationDefaultBackgroundColor() -> UIColor { return UIColor.white }
    class func appNavigationGreenForegroundColor() -> UIColor { return UIColor.white }
    class func appNavigationGreenBackgroundColor() -> UIColor { return UIColor.white }
    
    static var appPrimaryColor : UIColor {return UIColor(hex: "225B62")}
    static var buttonPrimaryColor : UIColor {return .black}
    static var labelPrimaryColor : UIColor {return .black}
    static var textFieldPrimaryColor : UIColor {return .black}
    static var loaderBgColor : UIColor {return UIColor.init(white: 0.8, alpha: 0.8)}
}

extension UIColor {
    @objc convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    func withAlpha(_ alpha: Float) -> UIColor {
        guard let components = cgColor.components else {
            return UIColor.black
        }
        
        let r: CGFloat = components[0]
        let g: CGFloat = components[1]
        var b: CGFloat = 1.0
        if components.count > 2 {
            b = components[2]
        }
        
        return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
}
