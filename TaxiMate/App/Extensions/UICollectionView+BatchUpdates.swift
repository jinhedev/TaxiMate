//
//  UICollectionView+BatchUpdates.swift
//  HSD
//
//  Created by rightmeow on 12/13/17.
//  Copyright © 2017 rightmeow. All rights reserved.
//

import UIKit

extension IndexPath {

    static func fromItem(_ item: Int) -> IndexPath {
        return IndexPath(item: item, section: 0)
    }

}

extension UICollectionView {

    func applyChanges(section: Int = 0, deletions: [Int], insertions: [Int], updates: [Int]) {
        performBatchUpdates({
            deleteItems(at: deletions.map(IndexPath.fromItem))
            insertItems(at: insertions.map(IndexPath.fromItem))
            reloadItems(at: updates.map(IndexPath.fromItem))
        }, completion: nil)
    }

}
