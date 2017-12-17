//
//  Session.swift
//  HSD
//
//  Created by rightmeow on 12/13/17.
//  Copyright © 2017 rightmeow. All rights reserved.
//

import Foundation
import RealmSwift

class Session: Object {

    @objc dynamic var session_id = ""
    @objc dynamic var is_loggedin: Bool = false
    @objc dynamic var created_at: NSDate = NSDate()
    @objc dynamic var expired_at: NSDate? = nil

    let user = LinkingObjects(fromType: User.self, property: "sessions")

    override static func primaryKey() -> String? {
        return "session_id"
    }

    convenience init(is_loggedin: Bool, expired_at: NSDate) {
        self.init()
        self.session_id = UUID().uuidString
        self.created_at = NSDate()
        self.expired_at = expired_at
        self.is_loggedin = is_loggedin
    }

}
