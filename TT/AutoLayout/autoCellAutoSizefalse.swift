//
//  autoCellAutoSizefalse.swift
//  SwiftTest
//
//  Created by 尹凡 on 4/11/18.
//  Copyright © 2018 尹凡. All rights reserved.
//

import Foundation

import UIKit

class autoCellAutoSizefalse: UITableViewCell {
    
    var leftTitle: UILabel?
    var centerTitle: UILabel?
    var rightTitle: UILabel?
    
    convenience init() {
        self.init(style: .default, reuseIdentifier: "autoCell")
        self.setUpViews()
        self.makeLayout()
        self.setText()
    }
    
    func setText() {
        guard let _left = leftTitle,let _rigint = rightTitle,let _center = centerTitle else {
            return
        }
        
        _left.text = "1234"
        _center.text = "$%^$%##^&&^"
        _rigint.text = "abcde"
        _left.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: UILayoutConstraintAxis.horizontal)
        
        _left.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
    }
    
    func setUpViews() {
        leftTitle = UILabel(frame: CGRect.zero)
        centerTitle = UILabel(frame: CGRect.zero)
        rightTitle = UILabel(frame: CGRect.zero)
        guard let _left = leftTitle,let _rigint = rightTitle,let _center = centerTitle else {
            return
        }
        _left.translatesAutoresizingMaskIntoConstraints = false
        _left.backgroundColor = .red
    
        _rigint.translatesAutoresizingMaskIntoConstraints = false
        _rigint.backgroundColor = .lightGray
        
      
        _center.backgroundColor = .yellow
          _center.translatesAutoresizingMaskIntoConstraints = false
//        _center.frame = CGRect(x: 200, y: 0, width: 100, height: 40)
        
        self.contentView.addSubview(_left)
        self.contentView.addSubview(_center)
        self.contentView.addSubview(_rigint)
    }
    
    
    func makeLayout() {
         guard let _left = leftTitle,let _rigint = rightTitle,let _center = centerTitle else {
            return
        }
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[l]-10-[c]-10-[r]|", options: [], metrics: nil,
            views: ["l":_left,"c":_center,"r":_rigint]))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[l]", options: [], metrics: nil,
            views: ["l":_left,]))
    }
}
