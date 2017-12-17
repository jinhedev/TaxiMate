//
//  MainUpcomingRidesCell.swift
//  HSD
//
//  Created by rightmeow on 12/12/17.
//  Copyright © 2017 rightmeow. All rights reserved.
//

import UIKit
import RealmSwift

enum MainRidesCellType {
    case upcoming
    case completed
}

class MainRidesCell: UICollectionViewCell {

    var cellType: MainRidesCellType? {
        didSet {
            performInitialFetch()
        }
    }
    var realmManager: RealmManager?
    var rides: Results<Ride>?
    var notificationToken: NotificationToken?

    var ridesViewController: RidesViewController?
    var placeholderBackgroundView: PlaceholderBackgroundView?

    static let cell_id = String(describing: MainRidesCell.self)
    static let nibName = String(describing: MainRidesCell.self)

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!

    private func setupCollectionView() {
        self.backgroundColor = UIColor.red
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.register(UINib(nibName: EmbededRideCell.nibName, bundle: nil), forCellWithReuseIdentifier: EmbededRideCell.cell_id)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCollectionView()
        self.setupBackgroundView()
        self.setupRealmManagerDelegate()
        let ride = Ride(driver_name: "Gordon", title: "Going to school", pickup_date: NSDate(), is_completed: false)
        let user = User(username: "sudofluff", first_name: "jin", last_name: "rightmeow", email: "jinhedev@gmail.com", password: "123123", role: 0)
        user.rides.append(ride)
//        realmManager?.addObject(objects: [user])
        // REMAKR: do NOT execute fetch here because cellType could be nil at this lifecycle
    }

}

extension MainRidesCell: PlaceholderBackgroundViewDelegate {

    fileprivate func setupBackgroundView() {
        placeholderBackgroundView = UINib(nibName: PlaceholderBackgroundView.nibName, bundle: nil).instantiate(withOwner: nil, options: nil).first as? PlaceholderBackgroundView
        self.collectionView.backgroundView = placeholderBackgroundView
        self.placeholderBackgroundView!.delegate = self
        self.placeholderBackgroundView!.isHidden = true
    }

    func placeholderBackgroundView(_ view: PlaceholderBackgroundView, didTapInfo button: UIButton) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: WebsViewController.storyboard_id) as? WebsViewController {
            viewController.url = "http://help.hopskipdrive.com"
            self.ridesViewController?.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    func placeholderBackgroundView(_ view: PlaceholderBackgroundView, didTapSchedule button: UIButton) {
        if let scheduleProcessViewController = self.ridesViewController?.storyboard?.instantiateViewController(withIdentifier: ScheduleProcessViewController.storyboard_id) as? ScheduleProcessViewController {
            let navController = UINavigationController(rootViewController: scheduleProcessViewController)
            self.ridesViewController?.present(navController, animated: true, completion: nil)
        }
    }

    func placeholderBackgroundView(_ view: PlaceholderBackgroundView, didTapText button: UIButton) {
        // ignore
    }

    func placeholderBackgroundView(_ view: PlaceholderBackgroundView, didTapEmail button: UIButton) {
        // ignore
    }

}

extension MainRidesCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }

}

extension MainRidesCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let unwrappedRides = self.rides?[indexPath.item] else { return CGSize.zero }
        let cellWidth = self.collectionView.frame.width
        var cellHeight: CGFloat = 16 + 16 + (0) + 8 + 22 + 22 + 16 + 16
        let titleLabelHeight = unwrappedRides.driver_name.heightForText(systemFont: 15, width: cellWidth - 32 - 56 - 16 - 32 - 56 - 16)
        cellHeight += titleLabelHeight
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let insets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        return insets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}

extension MainRidesCell: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.rides?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: EmbededRideCell.cell_id, for: indexPath) as? EmbededRideCell {
            cell.ride = self.rides?[indexPath.item]
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

}

extension MainRidesCell: RealmManagerDelegate {

    private func setupRealmManagerDelegate() {
        self.realmManager = RealmManager()
        self.realmManager!.delegate = self
    }

    func realmManager(_ manager: RealmManager, didErr error: Error) {
        print(error.localizedDescription)
    }

    func realmManager(_ manager: RealmManager, didFetchRides rides: Results<Ride>?) {
        guard let fetchedRides = rides else { return }
        if !fetchedRides.isEmpty {
            self.rides = fetchedRides
            self.setupRealmNotificationForCollectionView()
        }
        self.placeholderBackgroundView?.isHidden = fetchedRides.isEmpty ? false : true
        if self.cellType == MainRidesCellType.upcoming {
            self.placeholderBackgroundView?.type = PlaceholderType.upcoming
        } else {
            self.placeholderBackgroundView?.type = PlaceholderType.completed
        }
    }

    private func setupRealmNotificationForCollectionView() {
        notificationToken = self.rides!.observe({ [weak self] (changes) in
            guard let collectionView = self?.collectionView else { return }
            switch changes {
            case .initial:
                collectionView.reloadData()
            case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                collectionView.applyChanges(deletions: deletions, insertions: insertions, updates: modifications)
            case .error(let err):
                print(err.localizedDescription)
            }
        })
    }

    func performInitialFetch() {
        if self.rides == nil {
            if cellType == MainRidesCellType.upcoming {
                self.realmManager?.fetchRides(predicate: Ride.upcomingPredicate)
            } else if cellType == MainRidesCellType.completed {
                self.realmManager?.fetchRides(predicate: Ride.completedPredicate)
            }
        }
    }

}
