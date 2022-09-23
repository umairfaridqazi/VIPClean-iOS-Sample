//
//  BaseTableViewCell.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func updateCell(rowModel: BaseRowModel) {
        preconditionFailure("You have to override updateCell")
    }
}
