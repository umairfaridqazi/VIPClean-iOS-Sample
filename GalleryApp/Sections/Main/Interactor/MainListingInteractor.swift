//
//  MainListingInteractor.swift
//  GalleryApp
//
//  Created by Umair Farid on 31/08/2021.
//

import Foundation
class MainListingInteractor {
    // MARK: Properties

    let services = SharedServices()
    var presenter: MainListingPresentation?
}

extension MainListingInteractor: MainListingUseCase {
    // TODO: Implement use case methods

    func viewDidLoad(object: AnyObject?) {
        print("did load called from MainListingInteractor")
    }
    
    func networkRequest() {
        services.executePostSplashRequest(success: { model in
            // Handle success callback here
            print(model)
        }) { error in
            // Handle failure callback here
            print(error.localizedDescription)
        }
    }

    
}
