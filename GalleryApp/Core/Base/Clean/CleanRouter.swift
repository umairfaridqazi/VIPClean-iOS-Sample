//
//  VIPCleanRouter.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

protocol CleanRouter {}

extension CleanRouter {
    func setRootViewController(viewController: UIViewController) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        let navigationController = BaseNavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

}
