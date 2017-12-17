//
//  RidersViewController.swift
//  HSD
//
//  Created by rightmeow on 12/13/17.
//  Copyright © 2017 rightmeow. All rights reserved.
//

import UIKit
import RealmSwift

class RidersViewController: UIViewController {

    // MARK: - API

    var riders: Results<User>?
    var realmManager: RealmManager?
    var notificationToken: NotificationToken?

    lazy var avatarButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.setImage(#imageLiteral(resourceName: "settings"), for: UIControlState.normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleAvatar), for: UIControlEvents.touchUpInside)
        return button
    }()

    static let storyboard_id = String(describing: RidersViewController.self)

    @IBOutlet weak var ridersHeaderView: RidersHeaderView!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - NavigationBar

    @objc func handleAvatar() {
        if let settingsViewController = self.storyboard?.instantiateViewController(withIdentifier: SettingsViewController.storyboard_id) as? SettingsViewController {
            self.navigationController?.pushViewController(settingsViewController, animated: true)
        }
    }

    private func setupNavigationBar() {
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: avatarButton)]
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: RiderCell.nibName, bundle: nil), forCellReuseIdentifier: RiderCell.cell_id)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupTableView()
        self.setupRidersHeaderViewDelegate()
        self.setupRealmManagerDelegate()
        self.realmManager?.fetchUsers()
    }

}

extension RidersViewController: RidersHeaderViewDelegate {

    fileprivate func setupRidersHeaderViewDelegate() {
        self.ridersHeaderView.delegate = self
    }

    func didTapView(_ view: RidersHeaderView) {
        if let addUserViewController = self.storyboard?.instantiateViewController(withIdentifier: AddUserViewController.storyboard_id) as? AddUserViewController {
            let navController = UINavigationController(rootViewController: addUserViewController)
            self.present(navController, animated: true, completion: nil)
        }
    }

}

extension RidersViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }

}

extension RidersViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: RiderCell.cell_id) as? RiderCell {
            cell.rider = self.riders?[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return riders?.count ?? 0
    }

}

extension RidersViewController: RealmManagerDelegate {

    private func setupRealmManagerDelegate() {
        self.realmManager = RealmManager()
        self.realmManager!.delegate = self
    }

    private func setupRealmNotificationForTableView() {
        notificationToken = self.riders!.observe({ [weak self] (changes) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                tableView.applyChanges(deletions: deletions, insertions: insertions, updates: modifications)
            case .error(let err):
                print(err.localizedDescription)
            }
        })
    }

    func realmManager(_ manager: RealmManager, didFetchUsers users: Results<User>?) {
        guard let fetchedRiders = users else { return }
        if !fetchedRiders.isEmpty {
            self.riders = fetchedRiders
            self.setupRealmNotificationForTableView()
        }
    }

    func realmManager(_ manager: RealmManager, didErr error: Error) {
        print(error.localizedDescription)
    }

}
