//
//  MenuBarCell.swift
//  HSD
//
//  Created by rightmeow on 12/12/17.
//  Copyright © 2017 rightmeow. All rights reserved.
//

import UIKit

class MenuBarCell: UICollectionViewCell {

    override var isSelected: Bool {
        didSet {
            self.setSelected()
        }
    }

    var menu: Menu? {
        didSet {
            self.updateCell()
        }
    }

    static let cell_id = String(describing: MenuBarCell.self)
    static let nibName = String(describing: MenuBarCell.self)

    @IBOutlet weak var titleLabel: UILabel!

    func setSelected() {
        self.titleLabel.textColor = isSelected ? UIColor.orange : UIColor.darkGray
    }

    private func updateCell() {
        guard let unwrappedMenu = self.menu else { return }
        self.titleLabel.text = unwrappedMenu.title
    }

    private func setupCell() {
        self.backgroundColor = UIColor.white
        self.titleLabel.backgroundColor = UIColor.clear
        self.titleLabel.textColor = UIColor.darkGray
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCell()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
