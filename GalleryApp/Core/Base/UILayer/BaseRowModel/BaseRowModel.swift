//
//  BaseRowModel.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

class BaseRowModel: NSObject {
    var rowCellIdentifier = ""
    var rowValue: Any?
    var delegate: AnyObject?
    var rowHeight: CGFloat = UITableView.automaticDimension
}
