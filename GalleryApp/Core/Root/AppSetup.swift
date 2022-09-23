//
//  AppSetup.swift
//  GalleryApp
//
//  Created by Umair Farid on 31/08/2021.
//

import Foundation
import IQKeyboardManagerSwift
import UIKit
import UserNotifications

extension AppDelegate {
    internal func setupApp(window: UIWindow) {
//        _setupReachability()
//        _setupLocalization()
//        _setupFirebase()
//        _setupKeyboard()
        _boot()
    }
    
    
    internal func _setupFirebase() {
//        if let filePath = Bundle.main.path(forResource: Config.firebaseConfig, ofType: "plist"),
//            let options = FirebaseOptions(contentsOfFile: filePath) {
//            FirebaseApp.configure(options: options)
//        } else {
//            FirebaseApp.configure()
//        }
//
//        _setupNotifications()
    }
    
//    internal func _setupNotifications() {
//        _registerForPushNotifications()
//        UNUserNotificationCenter.current().delegate = self
//    }
    
//    internal func _setupKeyboard() {
//        IQKeyboardManager.shared.enable = true
//        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "done".localized
//        UIBarButtonItem.appearance().setTitleTextAttributes(
//            [
//                NSAttributedString.Key.font: UIFont(fontSize: FontSize.h2.rawValue, weight: .medium),
//                NSAttributedString.Key.foregroundColor: UIColor.black,
//        ], for: .normal)
//    }
    
//    internal func _setupReachability() {
//        _ = ReachabilityManager.shared.isConnected
//    }
    
    internal func _boot() {
        if let window = self.window {
//            window.backgroundColor = UIColor.sideMenuGradiant1Color()
            RootRouter().presentRootScreen(in: window)
        }
    }
    
    @objc internal func _reboot() {
//        RootRouter().setupAppRoot()
        // window.rootViewController = HubRouter.setupModule()
    }
}

