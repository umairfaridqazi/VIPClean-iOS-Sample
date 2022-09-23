//
//  MainListingViewController.swift
//  GalleryApp
//
//  Created by Umair Farid on 31/08/2021.
//  
//

import Foundation
import UIKit

class MainListingViewController: BaseViewController {

    // MARK: Properties

    var interactor: MainListingUseCase?
    var router: MainListingWireFrame?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.viewDidLoad(object: nil)
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        // Customize look & feel here
    }
}

extension MainListingViewController: MainListingView {
    // TODO: implement view output methods
}
