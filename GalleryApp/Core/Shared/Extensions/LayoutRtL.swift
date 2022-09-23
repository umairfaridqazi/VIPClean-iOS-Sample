//
//  LayoutRtL.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

class LayoutRtL: UICollectionViewFlowLayout {
    override func awakeFromNib() {
        super.awakeFromNib()
        if Version.iOS10 {
            self.collectionView?.transform = CGAffineTransform(scaleX: -1, y: 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                let index = IndexPath(item: 0, section: 0)
                self.collectionView?.scrollToItem(at: index, at: .left, animated: false)
            }
        }
    }
    override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return true
    }
}
