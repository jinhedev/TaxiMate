//
//  RideCell.swift
//  HSD
//
//  Created by rightmeow on 12/12/17.
//  Copyright © 2017 rightmeow. All rights reserved.
//

import UIKit

class EmbededRideCell: UICollectionViewCell {

    var ride: Ride? {
        didSet {
            self.updateCell()
        }
    }

    static let nibName = String(describing: EmbededRideCell.self)
    static let cell_id = String(describing: EmbededRideCell.self)

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titileLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!

    private func updateCell() {
        self.titileLabel.text = ride?.driver_name
        self.subtitleLabel.text = ride?.ride_id
    }

    private func setupCell() {
        self.backgroundColor = UIColor.red
        self.containerView.layer.cornerRadius = 8
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCell()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.titileLabel.text?.removeAll()
        self.subtitleLabel.text?.removeAll()
    }

}
