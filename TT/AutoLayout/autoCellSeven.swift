//
//  autoCellSeven.swift
//  SwiftTest
//
//  Created by 尹凡 on 4/22/18.
//  Copyright © 2018 尹凡. All rights reserved.
//

import Foundation


import UIKit


class MyCollection: UICollectionView {
    
//    var
    
    override var intrinsicContentSize: CGSize {
//       UIScreen.main.scr
        return CGSize(width: 100, height: 100)
    }
}

class autoCellSeven: UITableViewCell {
    
    var leftTitle: UILabel?
    var rightTitle: UILabel?
    var collect: UICollectionView?
    
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
        
        _left.text = "top"
        _rigint.text = "buttom"
    }
    
    
    func createFlowLayout() -> UICollectionViewFlowLayout {
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize(width: 100, height: 100)
        return flow
    }
    
    func setUpViews() {
        leftTitle = UILabel(frame: CGRect.zero)
        rightTitle = UILabel(frame: CGRect.zero)
        collect = MyCollection(frame: CGRect.zero, collectionViewLayout: self.createFlowLayout())
        guard let _left = leftTitle,
            let _rigint = rightTitle ,
            let _collect = collect else {
            return
        }
        
        _left.translatesAutoresizingMaskIntoConstraints = false
        _left.backgroundColor = .red
        
        _rigint.translatesAutoresizingMaskIntoConstraints = false
        _rigint.backgroundColor = .lightGray
        
        _collect.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(_left)
        self.contentView.addSubview(_rigint)
        self.contentView.addSubview(_collect)
    }
    
    
    func makeLayout() {
        guard let _left = leftTitle,
            let _rigint = rightTitle ,
            let _collect = collect else {
                return
        }
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[l]|", options: [], metrics: nil,
            views: ["l":_left]))
        
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[r]|", options: [], metrics: nil,
            views: ["r":_rigint]))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[c]|", options: [], metrics: nil,
            views: ["c":_collect]))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[l][c][r]|", options: [], metrics: nil,
            views: ["l":_left,"c":_collect,"r":_rigint]))
    }
}
