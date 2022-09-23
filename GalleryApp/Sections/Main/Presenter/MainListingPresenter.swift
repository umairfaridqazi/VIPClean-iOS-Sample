//
//  MainListingPresenter.swift
//  GalleryApp
//
//  Created by Umair Farid on 31/08/2021.
//  
//

import Foundation

class MainListingPresenter {
    // MARK: Properties

    weak var view: MainListingView?
    var object: AnyObject?
}

extension MainListingPresenter: MainListingPresentation {
    func viewDidLoad(object: AnyObject?) {
        self.object = object
    }
}

extension MainListingPresenter {

}
