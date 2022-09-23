//
//  Font.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

enum FontFamily{
   static let  REGULAR = "Bariol"
   static let  BOLD = "Bariol-Bold"
   static let  SEMIBOLD = ""
   static let  MEDIUM = ""
   static let  LIGHT = "Bariol-Light"
   static let  THIN = "Bariol-Thin"
}

@objc extension UIFont {
    
    func appFont(type : String, size: CGFloat) -> UIFont{
        return UIFont(name: type, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func fallbackFont() -> UIFont {
        return UIFont.systemFont(ofSize: 17)
    }
    
    class func appRegularFont(withSize size: CGFloat) -> UIFont {
        return UIFont(name: FontFamily.REGULAR, size: size) ?? fallbackFont()
    }
    
    class func appMediumFont(withSize size: CGFloat) -> UIFont {
         return UIFont(name: FontFamily.MEDIUM, size: size) ?? fallbackFont()
    }
    
    class func appBoldFont(withSize size: CGFloat) -> UIFont {
       return UIFont(name: FontFamily.BOLD, size: size) ?? fallbackFont()
    }
    
    class func appSemiBoldFont(withSize size: CGFloat) -> UIFont {
           return UIFont(name: FontFamily.SEMIBOLD, size: size) ?? fallbackFont()
    }
    
    class func fontWithSize(withSize size: CGFloat, style: String) -> UIFont {
        return fontWithSize(withSize: size, style: style)
    }
    
    func size(OfString string: String, constrainedToWidth width: CGFloat) -> CGSize {
        return NSString(string: string).boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude),
                                                     options: .usesLineFragmentOrigin,
                                                     attributes: [.font: self],
                                                     context: nil).size
    }
}
