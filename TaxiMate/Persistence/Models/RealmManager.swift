//
//  RealmManager.swift
//  HSD
//
//  Created by rightmeow on 12/12/17.
//  Copyright © 2017 rightmeow. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmManagerDelegate: NSObjectProtocol {
    func realmManager(_ manager: RealmManager, didErr error: Error)
    func realmManager(_ manager: RealmManager, didFetchSessions sessions: Results<Session>?)
    func realmManager(_ manager: RealmManager, didFetchRides rides: Results<Ride>?)
    func realmManager(_ manager: RealmManager, didFetchUsers users: Results<User>?)
    func realmManager(_ manager: RealmManager, didAddObjects objects: [Object])
}

extension RealmManagerDelegate {
    func realmManager(_ manager: RealmManager, didFetchSessions sessions: Results<Session>?) {}
    func realmManager(_ manager: RealmManager, didFetchRides rides: Results<Ride>?) {}
    func realmManager(_ manager: RealmManager, didFetchUsers users: Results<User>?) {}
    func realmManager(_ manager: RealmManager, didAddObjects objects: [Object]) {}
}

var realm: Realm!

func setupRealm() {
    let config = Realm.Configuration(fileURL: URL.inDocumentDirectory(fileName: "default.realm"), schemaVersion: 0, migrationBlock: nil, objectTypes: [User.self, Ride.self, Session.self])
    realm = try! Realm(configuration: config)
}

class RealmManager: NSObject {

    weak var delegate: RealmManagerDelegate?
    static var pathForDefaultContainer: URL? { return Realm.Configuration.defaultConfiguration.fileURL }

    // Auth

    func fetchSession() {
        let sessions = realm.objects(Session.self)
        self.delegate?.realmManager(self, didFetchSessions: sessions)
    }

    // Fetch

    func fetchRides(predicate: NSPredicate) {
        let rides = realm.objects(Ride.self).sorted(byKeyPath: "created_at", ascending: false).filter(predicate)
        self.delegate?.realmManager(self, didFetchRides: rides)
    }

    func fetchUsers() {
        let users = realm.objects(User.self)
        self.delegate?.realmManager(self, didFetchUsers: users)
    }

    // Add

    func addObject(objects: [Object]) {
        do {
            try realm.write {
                realm.add(objects, update: true)
            }
            self.delegate?.realmManager(self, didAddObjects: objects)
        } catch let err {
            self.delegate?.realmManager(self, didErr: err)
        }
    }

}
