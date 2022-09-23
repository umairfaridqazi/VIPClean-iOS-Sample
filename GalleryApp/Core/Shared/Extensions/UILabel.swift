//
//  UILabel.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

extension UILabel {
    func setAttributedText(firstStringText: String = "", firstStringColor: UIColor = UIColor.labelPrimaryColor, size1: CGFloat = 20, secondStringText: String = "", secondStringColor: UIColor = UIColor.labelPrimaryColor, size2: CGFloat = 20) {
        let strComplete = "\(firstStringText) \(secondStringText)"
        
        let attributedString = NSMutableAttributedString(string: strComplete)
        
        attributedString.addAttribute(.foregroundColor, value: firstStringColor, range: (strComplete as NSString).range(of: firstStringText))
        
        attributedString.addAttribute(.font, value: UIFont.appRegularFont(withSize: size1), range: (strComplete as NSString).range(of: firstStringText))
        
        attributedString.addAttribute(.foregroundColor, value: secondStringColor, range: (strComplete as NSString).range(of: secondStringText))
        
        attributedString.addAttribute(.font, value: UIFont.appBoldFont(withSize: size2), range: (strComplete as NSString).range(of: secondStringText))
        
        self.attributedText = attributedString
    }
    
    @IBInspectable
    var letterSpace: CGFloat {
        set {
            let attributedString: NSMutableAttributedString!
            if let currentAttrString = attributedText {
                attributedString = NSMutableAttributedString(attributedString: currentAttrString)
            }
            else {
                attributedString = NSMutableAttributedString(string: text ?? "")
                text = nil
            }
            
            attributedString.addAttribute(NSAttributedString.Key.kern,
                                          value: newValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            
            attributedText = attributedString
        }
        
        get {
            if let currentLetterSpace = attributedText?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            }
            else {
                return 0
            }
        }
    }
    
    @IBInspectable
       var lineSpace: CGFloat {
           set{

               //get our existing style or make a new one
               let paragraphStyle: NSMutableParagraphStyle
               if let existingStyle = attributedText?.attribute(NSAttributedString.Key.paragraphStyle, at: 0, effectiveRange: .none) as? NSParagraphStyle, let mutableCopy = existingStyle.mutableCopy() as? NSMutableParagraphStyle  {
                   paragraphStyle = mutableCopy
               } else {
                   paragraphStyle = NSMutableParagraphStyle()
                   paragraphStyle.lineSpacing = 1.0
                   paragraphStyle.alignment = self.textAlignment
               }
               paragraphStyle.lineHeightMultiple = newValue

               //set our text from existing text
               let attrString = NSMutableAttributedString()
               if let text = self.text {
                   attrString.append( NSMutableAttributedString(string: text))
                attrString.addAttribute(NSAttributedString.Key.font, value: self.font as Any, range: NSMakeRange(0, attrString.length))
               }
               else if let attributedText = self.attributedText {
                   attrString.append( attributedText)
               }

               //add our attributes and set the new text
               attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
               self.attributedText = attrString
           }

           get {
               if let paragraphStyle = attributedText?.attribute(NSAttributedString.Key.paragraphStyle, at: 0, effectiveRange: .none) as? NSParagraphStyle {
                   return paragraphStyle.lineHeightMultiple
               }
               return 0
        }
    }
}
