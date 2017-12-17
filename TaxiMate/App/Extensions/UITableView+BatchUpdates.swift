//
//  UITableView+BatchUpdates.swift
//  HSD
//
//  Created by rightmeow on 12/13/17.
//  Copyright © 2017 rightmeow. All rights reserved.
//

import UIKit

extension IndexPath {

    static func fromRow(_ row: Int) -> IndexPath {
        return IndexPath(row: row, section: 0)
    }

}

extension UITableView {

    func applyChanges(section: Int = 0, deletions: [Int], insertions: [Int], updates: [Int]) {
        performBatchUpdates({
            deleteRows(at: deletions.map(IndexPath.fromRow), with: .automatic)
            insertRows(at: insertions.map(IndexPath.fromRow), with: .automatic)
            reloadRows(at: updates.map(IndexPath.fromRow), with: .automatic)
        }, completion: nil)
    }

}
