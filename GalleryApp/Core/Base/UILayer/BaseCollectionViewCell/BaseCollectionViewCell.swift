//
//  BaseCollectionViewCell.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(forName: NSLocale.currentLocaleDidChangeNotification, object: nil, queue: nil) { [weak self] _ in
            self?.setupLocalizedAppearance()
        }
        setupLocalizedAppearance()
    }
    
    func updateCell(rowModel: BaseRowModel) {
        preconditionFailure("You have to override updateCell")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupLocalizedAppearance() {
        // called whenever init and language of app changed functionality called
    }
}
