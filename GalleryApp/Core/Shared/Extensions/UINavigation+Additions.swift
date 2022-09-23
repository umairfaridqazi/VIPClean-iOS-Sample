//
//  UINavigation+Additions.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func makeTransparent(withTint tint: UIColor = .white, backGroundImage: UIImage = UIImage()) {
        navigationBar.setBackgroundImage(backGroundImage, for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = tint
        navigationBar.titleTextAttributes = [.foregroundColor: tint]
    }
    
//    open override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        setupnavFonts()
//    }
//
//    fileprivate func setupnavFonts() {
//        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : (UIFont(name: "Gilroy-Medium", size: 20) ?? UIFont.systemFont(ofSize: 20)), NSAttributedString.Key.foregroundColor: UIColor.white]
//
//    }
    
}
