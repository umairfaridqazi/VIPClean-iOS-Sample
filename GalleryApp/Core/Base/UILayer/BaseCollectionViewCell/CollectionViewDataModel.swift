//
//  CollectionViewDataModel.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

class CollectionViewDataModel: NSObject {
    
    var cellIdentifier:String!
    var sharedData:Any?
    var secondaryData:Any?
    var cellTag:Int?
    var title: String?
    var isSelected = false
}


protocol BaseCollectionViewCellProtocol: class {
}
