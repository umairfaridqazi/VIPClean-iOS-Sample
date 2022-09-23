//
//  MainListingRouter.swift
//  GalleryApp
//
//  Created by Umair Farid on 31/08/2021.
//  
//

import Foundation
import UIKit

class MainListingRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> MainListingViewController {
        let viewController = MainListingViewController.instantiate(fromAppStoryboard: .MainListing)
        let presenter = MainListingPresenter()
        let router = MainListingRouter()
        let interactor = MainListingInteractor()

        viewController.interactor =  interactor

        interactor.presenter = presenter
        viewController.router = router
        presenter.view = viewController
        router.view = viewController

        return viewController
    }
}

extension MainListingRouter: MainListingWireFrame {
    // TODO: Implement wireframe methods
}
