//
//  String+UIViewHeight.swift
//  HSD
//
//  Created by rightmeow on 12/13/17.
//  Copyright © 2017 rightmeow. All rights reserved.
//

import UIKit

extension String {

    func heightForText(systemFont size: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: size)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font : font], context: nil)
        return ceil(rect.height)
    }

}
