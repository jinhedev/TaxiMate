//
//  Ride.swift
//  HSD
//
//  Created by rightmeow on 12/12/17.
//  Copyright © 2017 rightmeow. All rights reserved.
//

import Foundation
import RealmSwift

class Ride: Object {

    @objc dynamic var ride_id = ""
    @objc dynamic var driver_name = ""
    @objc dynamic var title = ""
    @objc dynamic var created_at: NSDate!
    @objc dynamic var updated_at: NSDate?
    @objc dynamic var pickup_date: NSDate?
    @objc dynamic var is_completed: Bool = false

    override static func primaryKey() -> String? {
        return "ride_id"
    }

    var users = List<User>()

    let rides = LinkingObjects(fromType: User.self, property: "rides")

    static let upcomingPredicate = NSPredicate(format: "is_completed == %@", NSNumber(booleanLiteral: false))
    static let completedPredicate = NSPredicate(format: "is_completed == %@", NSNumber(booleanLiteral: true))

    convenience init(driver_name: String, title: String, pickup_date: NSDate, is_completed: Bool) {
        self.init()
        self.ride_id = UUID().uuidString // in real life, this property is generated by the backend API
        self.driver_name = driver_name
        self.title = title
        self.pickup_date = pickup_date
        self.created_at = NSDate()
        self.updated_at = nil
        self.is_completed = is_completed
    }

}
