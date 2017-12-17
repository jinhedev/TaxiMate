//
//  URL+documents.swift
//  HSD
//
//  Created by rightmeow on 12/13/17.
//  Copyright © 2017 rightmeow. All rights reserved.
//

import Foundation

// MARK: - NSURL + Document

extension URL {

    static func inDocumentDirectory(fileName: String) -> URL {
        let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        return URL(fileURLWithPath: dir, isDirectory: true).appendingPathComponent(fileName)
    }

}
