//
//  UILabel.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

extension UILabel {
    func setSizeFont (sizeFont: Double) {
        self.font =  UIFont(name: self.font.fontName, size: CGFloat(sizeFont))! //"Graphik-Medium"
        self.sizeToFit()
    }
}

extension UILabel{
    func addImage(imageName: String)
    {
        let attachment:NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: imageName)

        let attachmentString:NSAttributedString = NSAttributedString(attachment: attachment)
        let myString:NSMutableAttributedString = NSMutableAttributedString(string: self.text!, attributes: [
            NSAttributedString.Key.baselineOffset: 1.5,
        ])
        myString.insert(attachmentString, at: 0)

        self.attributedText = myString
    }
}

//For changing font to urdu
extension UILabel {
    @IBInspectable
    var urduCheck: Bool {
        set {
            /*if(newValue) {
                if(CoreLanguageManger.shared.isRightToLeft) {
                    //Checking if font assigned is regular or not
                    if self.font.fontName.range(of:"-Regular") != nil {
                        self.font = UIFont.notoNaskhArabic(ofSize: self.font.pointSize, weight: .regular)
                    }else{
                        self.font = UIFont.notoNaskhArabic(ofSize: self.font.pointSize, weight: .bold)
                    }
                }
            }*/
        }
        get {
            return self.urduCheck
        }
    }
    
    var substituteFont: UIFont {
        get { return self.font }
        set {
            /*if(CoreLanguageManger.shared.isRightToLeft) {
                //Checking if font assigned is regular or not
                if newValue.fontName.range(of:"-Regular") != nil {
                    self.font = UIFont.notoNaskhArabic(ofSize: self.font.pointSize, weight: .regular)
                }else{
                    self.font = UIFont.notoNaskhArabic(ofSize: self.font.pointSize, weight: .bold)
                }
            }else{
                self.font = newValue
            }*/
        }
    }
}

