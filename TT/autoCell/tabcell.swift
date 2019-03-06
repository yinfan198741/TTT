//
//  tabcell.swift
//  SwiftTest
//
//  Created by 尹凡 on 4/8/18.
//  Copyright © 2018 尹凡. All rights reserved.
//

import Foundation

import UIKit

class autoCell: UITableViewCell {
 
    var leftTitle: UILabel?
    var rightTitle: UILabel?
    
    convenience init() {
        self.init(style: .default, reuseIdentifier: "autoCell")
        self.setUpViews()
        self.makeLayout()
        self.setText()
    }
    
    func setText() {
        guard let _left = leftTitle,let _rigint = rightTitle else {
            return
        }

        _left.text = "1234123412341234123412341234"
        _rigint.text = "abcdeabcdeabcdeabcdeabcdeabcde"
//        _left.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: UILayoutConstraintAxis.horizontal)
//         _left.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: UILayoutConstraintAxis.horizontal)
        _rigint.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    func setUpViews() {
        leftTitle = UILabel(frame: CGRect.zero)
        rightTitle = UILabel(frame: CGRect.zero)
        guard let _left = leftTitle,let _rigint = rightTitle else {
            return
        }
        _left.translatesAutoresizingMaskIntoConstraints = false
        _left.backgroundColor = .red
        _rigint.translatesAutoresizingMaskIntoConstraints = false
        _rigint.backgroundColor = .lightGray
        self.contentView.addSubview(_left)
        self.contentView.addSubview(_rigint)
    }
    
    
    func makeLayout() {
        guard let _left = leftTitle,let _rigint = rightTitle else {
            return
        }
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[l]-10-[r]|", options: [], metrics: nil,
            views: ["l":_left,"r":_rigint]))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-10-[l]-10-|", options: [], metrics: nil,
            views: ["l":_left,]))
    }
}
