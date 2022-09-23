//
//  RootRouter.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

class RootRouter: RootWireframe {
    func presentRootScreen(in window: UIWindow) {
        let vc = MainListingRouter.setupModule()
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}
