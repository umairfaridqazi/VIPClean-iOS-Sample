//
//  VIPCleanView.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit
import Foundation

protocol CleanView: class {
    func showLoading()
    func hideLoading()
    func showError()
    func showError(error: NSError)
}

extension CleanView where Self: BaseViewController {
    func showLoading() {
        DispatchQueue.main.async {
         ProgressIndicator.shared().show()
        }
    }

    func hideLoading() {
        DispatchQueue.main.async {
         ProgressIndicator.shared().hide()
        }
    }

    func showError() {
        //AlertManager.showAlert(title: "Error", message: Constants.Error.genericErrorMessage)
    }

    func showError(error: NSError) {
        let message = error.localizedDescription
        //AlertManager.showAlert(title: "Error", message: message)
    }
}
