//
//  UIFontExtensions.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

//MARK:- WorkSansType
extension UIFont {
    enum WorkSansType {
        case black
        case blackItalic
        case bold
        case boldItalic
        case extraBold
        case extraBoldItalic
        case extraLight
        case extraLightItalic
        case italic
        case light
        case lightItalic
        case medium
        case mediumItalic
        case regular
        case semiBold
        case semiBoldItalic
        case thin
        case thinItalic
        

        var rawName: String {
            switch self {
            case .black:
                return "WorkSans-Black"
            case .blackItalic:
                return "WorkSans-BlackItalic"
            case .bold:
                return "WorkSans-Bold"
            case .boldItalic:
                return "WorkSans-BoldItalic"
            case .extraBold:
                return "WorkSans-ExtraBold"
            case .extraBoldItalic:
                return "WorkSans-ExtraBoldItalic"
            case .extraLight:
                return "WorkSans-ExtraLight"
            case .extraLightItalic:
                return "WorkSans-ExtraLightItalic"
            case .italic:
                return "WorkSans-Italic"
            case .light:
                return "WorkSans-Light"
            case .lightItalic:
                return "WorkSans-LightItalic"
            case .medium:
                return "WorkSans-Medium"
            case .mediumItalic:
                return "WorkSans-MediumItalic"
            case .regular:
                return "WorkSans-Regular"
            case .semiBold:
                return "WorkSans-SemiBold"
            case .semiBoldItalic:
                return "WorkSans-SemiBoldItalic"
            case .thin:
                return "WorkSans-Thin"
            case .thinItalic:
                return "WorkSans-ThinItalic"
            }
        }
    }

    static func workSansFont(ofSize size: CGFloat, weight: WorkSansType) -> UIFont {
        return UIFont(name: weight.rawName, size: size)!
    }
}

//MARK:- CoconType
extension UIFont {
    enum CoconType {
        case regularCoco
        case regularCondensed
        case lightCoco
        
        var rawName: String {
            switch self {
            case .regularCoco:
                return "Cocon-Regular"
            case .regularCondensed:
                return "Cocon-RegularCondensed"
            case .lightCoco:
                return "Cocon-Light"
            }
        }
    }

    static func cocoFont(ofSize size: CGFloat, weight: CoconType) -> UIFont {
        return UIFont(name: weight.rawName, size: size)!
    }
}

//MARK:- NotoNaskhArabic
extension UIFont {
    enum NotoNaskhArabic {
        case regular
        case bold
        
        var rawName: String {
            switch self {
            case .regular:
                return "NotoNaskhArabic"
            case .bold:
                return "NotoNaskhArabic-Bold"
            }
        }
    }

    static func notoNaskhArabic(ofSize size: CGFloat, weight: NotoNaskhArabic) -> UIFont {
        return UIFont(name: weight.rawName, size: size)!
    }
}

//MARK:- NotoNaskhArabicUI
extension UIFont {
    enum NotoNaskhArabicUI {
        case regular
        case bold
        
        var rawName: String {
            switch self {
            case .regular:
                return "NotoNaskhArabicUI"
            case .bold:
                return "NotoNaskhArabicUI-Bold"
            }
        }
    }

    static func notoNaskhArabicUI(ofSize size: CGFloat, weight: NotoNaskhArabicUI) -> UIFont {
        return UIFont(name: weight.rawName, size: size)!
    }
}
