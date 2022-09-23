//
//  ProgressIndicator.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

@objc class ProgressIndicator: UIView {
    // Public properties
    var size: CGFloat = 0.0
    
    // Private members
    private var indicatorView: UIActivityIndicatorView?
    private var bgView: UIView?
    private var shouldShowFullScreen = false
    var indicatorColor: UIColor = .black
    var bgColor: UIColor = .loaderBgColor
    
    @objc static var sharedInstance: ProgressIndicator = {
        var sharedIndicator = ProgressIndicator()
        sharedIndicator.size = 70
        sharedIndicator.shouldShowFullScreen = true
        return sharedIndicator
    }()
    
    class func shared() -> ProgressIndicator {
        return sharedInstance
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showInScreenIndicator()
    }
    
    func showInScreenIndicator() {
        shouldShowFullScreen = false
        indicatorView = getIndicatorWithSize(min(bounds.size.width, bounds.size.height))
        indicatorView?.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        indicatorView?.startAnimating()
        if let indicator = indicatorView {
            addSubview(indicator)
        }
    }
    
    @objc func show(asFullScreen shouldFullScreen: Bool = true) {
        shouldShowFullScreen = shouldFullScreen
        DispatchQueue.main.async(execute: {
            if self.indicatorView?.isAnimating == nil || self.indicatorView?.isAnimating == false {
                self.indicatorView = self.getIndicatorWithSize(self.size)
                self.indicatorView?.startAnimating()
                if let indicatorView = self.indicatorView {
                    UIApplication.shared.keyWindow?.addSubview(indicatorView)
                }
            }
        })
    }
    
    @objc func hide() {
        DispatchQueue.main.async(execute: {
            self.bgView?.removeFromSuperview()
            self.indicatorView?.stopAnimating()
            self.indicatorView?.removeFromSuperview()
        })
    }
    
    func isAnimating() -> Bool {
        return indicatorView?.isAnimating ?? false
    }
    
    func getIndicatorWithSize(_ size: CGFloat) -> UIActivityIndicatorView {
        let indicatorView = createIndicatorView(withSize: size)
        if shouldShowFullScreen {
            let screenSize = UIScreen.main.bounds
            bgView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.size.width, height: screenSize.size.height))
            
            if let bg = bgView {
                bg.backgroundColor = bgColor
                UIApplication.shared.keyWindow?.addSubview(bg)
            }
        }
        return indicatorView
    }
    
    func createIndicatorView(withSize size: CGFloat) -> UIActivityIndicatorView {
        let screenSize = UIScreen.main.bounds
        
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.color = indicatorColor
        activityIndicatorView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicatorView.frame = CGRect(x: 0, y: 0, width: screenSize.size.width, height: screenSize.size.height)
        if let center = UIApplication.shared.keyWindow?.rootViewController?.view.center {
            activityIndicatorView.center = center
        }
        UIApplication.shared.keyWindow?.rootViewController?.view.endEditing(true)
        return activityIndicatorView
    }
}
