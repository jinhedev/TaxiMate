//
//  PlaceholderBackgroundView.swift
//  HSD
//
//  Created by rightmeow on 12/12/17.
//  Copyright © 2017 rightmeow. All rights reserved.
//

import UIKit

protocol PlaceholderBackgroundViewDelegate: NSObjectProtocol {
    func placeholderBackgroundView(_ view: PlaceholderBackgroundView, didTapSchedule button: UIButton)
    func placeholderBackgroundView(_ view: PlaceholderBackgroundView, didTapInfo button: UIButton)
    func placeholderBackgroundView(_ view: PlaceholderBackgroundView, didTapEmail button: UIButton)
    func placeholderBackgroundView(_ view: PlaceholderBackgroundView, didTapText button: UIButton)
}

enum PlaceholderType {
    case upcoming
    case completed
    case promotion
}

class PlaceholderBackgroundView: UIView {

    var type: PlaceholderType? {
        didSet {
            guard let type = type else { return }
            switch type {
            case .upcoming:
                self.placeholderImageView.image = #imageLiteral(resourceName: "WavingHand")
                self.titleLabel.text = "Welcome"
                self.subtitleLabel.text = "What would you like to do?"
                self.emailButton.isHidden = true
                self.textButton.isHidden = true
            case .completed:
                self.placeholderImageView.image = #imageLiteral(resourceName: "logo")
                self.titleLabel.text = "No completed rides..."
                self.subtitleLabel.text = "...yet"
                self.scheduleButton.isHidden = true
                self.infoButton.isHidden = true
                self.emailButton.isHidden = true
                self.textButton.isHidden = true
            case .promotion:
                self.placeholderImageView.image = #imageLiteral(resourceName: "Gift")
                self.titleLabel.text = "Give & Get Free Rides"
                self.subtitleLabel.text = "Refer to a friend for $20 off"
                self.scheduleButton.isHidden = true
                self.infoButton.isHidden = true
                self.emailButton.isHidden = false
                self.textButton.isHidden = false
            }
        }
    }

    weak var delegate: PlaceholderBackgroundViewDelegate?

    static let nibName = String(describing: PlaceholderBackgroundView.self)

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var placeholderImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var scheduleButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var placeholderImageViewHeightConstraint: NSLayoutConstraint!

    @IBAction func handleSchedule(_ sender: UIButton) {
        self.delegate?.placeholderBackgroundView(self, didTapSchedule: sender)
    }

    @IBAction func handleMoreInfo(_ sender: UIButton) {
        self.delegate?.placeholderBackgroundView(self, didTapInfo: sender)
    }

    @IBAction func handleEmail(_ sender: UIButton) {
        self.delegate?.placeholderBackgroundView(self, didTapEmail: sender)
    }

    @IBAction func handleText(_ sender: UIButton) {
        self.delegate?.placeholderBackgroundView(self, didTapText: sender)
    }

    private func setupView() {
        self.backgroundColor = UIColor.white
        self.placeholderImageView.layer.cornerRadius = self.placeholderImageViewHeightConstraint.constant / 2
        self.scheduleButton.layer.cornerRadius = 8
        self.infoButton.layer.cornerRadius = 8
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }

}
