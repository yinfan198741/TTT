//
//  tabcellTow.swift
//  SwiftTest
//
//  Created by 尹凡 on 4/9/18.
//  Copyright © 2018 尹凡. All rights reserved.
//

import Foundation
import UIKit

class autoCellTow:  autoCell
{
    override func setText() {
            guard let _left = leftTitle,let _rigint = rightTitle else {
                return
            }
        _left.text = "1234567890123456789012345678901234567890"
        _left.numberOfLines = 2
        _rigint.text = "abcdefghijkabcdefghijkabcdefghijkabcdefghijk"
    }
    
    override func makeLayout() {
        guard let _left = leftTitle,let _rigint = rightTitle else {
            return
        }

        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[l(==100)]-10-[r]|", options: [.alignAllCenterY], metrics: nil,
            views: ["l":_left,"r":_rigint]))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[l]|", options: [], metrics: nil,
            views: ["l":_left,]))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[r]|", options: [], metrics: nil,
            views: ["r":_rigint,]))
    }
    
}

