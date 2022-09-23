//
//  AlertManager.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

@objc open class AlertManager: UIAlertController {
    @objc open class func showAlert(title: String? = "", message: String? = "", preferredStyle: UIAlertController.Style = .alert, alertActions: [UIAlertAction]?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if let actions = alertActions {
            for action in actions {
                alert.addAction(action)
            }
        }
        
        UIApplication.shared.keyWindow!.rootViewController!.present(alert, animated: true, completion: nil)
    }
    


}
