//
//  MenuBarView.swift
//  HSD
//
//  Created by rightmeow on 12/12/17.
//  Copyright © 2017 rightmeow. All rights reserved.
//

import UIKit

class MenuBarView: UIView {

    // MARK: - API

    var selectedIndexPath: IndexPath?
    var menus: [Menu] = [Menu(title: "Upcoming"), Menu(title: "Completed")]
    weak var ridesViewController: RidesViewController?

    static let nibName = String(describing: MenuBarView.self)

    @IBOutlet var view: UIView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var indicatorViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var indicatorViewLeadingConstraint: NSLayoutConstraint!

    // MARK: - Lifecycle

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: MenuBarView.nibName, bundle: nil).instantiate(withOwner: self, options: nil)
        self.setupView()
        self.setupCollectionView()
        self.setupCollectionViewFlowLayout()
    }

    // MARK: - View

    private func setupView() {
        self.addSubview(view)
        self.view.frame = self.bounds
        self.view.backgroundColor = UIColor.white
        self.indicatorView.backgroundColor = UIColor.orange
        self.indicatorView.layer.cornerRadius = self.indicatorViewHeightConstraint.constant / 2
    }

    // MARK: - UICollectionView

    private func setupCollectionView() {
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = UIColor.red
        self.collectionView.register(UINib(nibName: MenuBarCell.nibName, bundle: nil), forCellWithReuseIdentifier: MenuBarCell.cell_id)
        // initial selected state for the first cell
        let initialSelectedIndexPath = IndexPath(item: 0, section: 0)
        self.collectionView.selectItem(at: initialSelectedIndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition.top)
        self.selectedIndexPath = initialSelectedIndexPath // initial selectedIndexPath
    }

}

extension MenuBarView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: MenuBarCell.cell_id, for: indexPath) as? MenuBarCell {
            cell.menu = self.menus[indexPath.item]
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }

}

extension MenuBarView: UICollectionViewDelegateFlowLayout {

    fileprivate func setupCollectionViewFlowLayout() {
        self.collectionViewFlowLayout.scrollDirection = .horizontal
        self.collectionViewFlowLayout.minimumLineSpacing = 0
        self.collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = self.collectionView.frame.width / 2
        let cellHeight = self.collectionView.frame.height
        return CGSize(width: cellWidth, height: cellHeight)
    }

}

extension MenuBarView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        self.ridesViewController?.scrollToIndex(menuIndex: indexPath.item)
    }

}
