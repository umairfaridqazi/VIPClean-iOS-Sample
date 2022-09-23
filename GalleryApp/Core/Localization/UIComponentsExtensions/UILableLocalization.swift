//
//  UILableLocalization.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

extension UILabel {
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        NotificationCenter.default.addObserver(forName: NSLocale.currentLocaleDidChangeNotification, object: nil, queue: nil) { _ in
            self.changeDirection()
        }
        self.changeDirection()
    }
    
    @objc func changeDirection() {
        if self.textAlignment == .right || self.textAlignment == .left || self.textAlignment == .natural {
            self.textAlignment = UIApplication.isRTL() ? .right : .left
        }
    }
    
    open override func removeFromSuperview() {
        super.removeFromSuperview()
        NotificationCenter.default.removeObserver(self)
    }
}
