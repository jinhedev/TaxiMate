//
//  RidersHeaderView.swift
//  HSD
//
//  Created by rightmeow on 12/13/17.
//  Copyright © 2017 rightmeow. All rights reserved.
//

import UIKit

protocol RidersHeaderViewDelegate: NSObjectProtocol {
    func didTapView(_ view: RidersHeaderView)
}

class RidersHeaderView: UIView {

    // MARK: - API

    var tapGestureRecognizer: UITapGestureRecognizer!
    weak var delegate: RidersHeaderViewDelegate?

    static let nibName = String(describing: RidersHeaderView.self)

    @IBOutlet var view: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var plusImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    @objc func handleTap() {
        self.delegate?.didTapView(self)
    }

    private func setupView() {
        self.addSubview(view)
        self.view.frame = self.bounds
        self.backgroundColor = UIColor.white
        self.frameView.layer.cornerRadius = 22
        self.plusImageView.tintColor = UIColor.white
        self.plusImageView.image = #imageLiteral(resourceName: "Plus") // <<-- image literal
        self.titleLabel.text = "Add Rider"
    }

    private func setupTapGesture() {
        self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGestureRecognizer)
    }

    // MARK: - Lifecycle

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: RidersHeaderView.nibName, bundle: nil).instantiate(withOwner: self, options: nil)
        self.setupView()
        self.setupTapGesture()
    }


}
