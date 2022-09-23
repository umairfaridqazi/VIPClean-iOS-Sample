//
//  MainListingContract.swift
//  GalleryApp
//
//  Created by Umair Farid on 31/08/2021.
//  
//

import Foundation

protocol MainListingView: CleanView {
    // TODO: Declare view methods
}

protocol MainListingPresentation: CleanPresenter {
    // TODO: Declare view methods
}

protocol MainListingWireFrame: CleanRouter {
    // TODO: Declare wireframe methods
}

protocol MainListingUseCase: CleanInteractor {
    // TODO: Declare wireframe methods
    func viewDidLoad(object: AnyObject?)
}


