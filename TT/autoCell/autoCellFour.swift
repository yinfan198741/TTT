//
//  autoCellFour.swift
//  SwiftTest
//
//  Created by 尹凡 on 4/9/18.
//  Copyright © 2018 尹凡. All rights reserved.
//

import Foundation

import UIKit

class autoCellFour:  UITableViewCell {
   
    var leftTitle: UILabel?
    var rightTitle: UILabel?
    var iconImage: UIImageView?
    
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
        
        _left.text = "1234"
        _rigint.text = "abcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcasdjflasjdfasjdflajsl;fjalsjdfaslkdjflasdjlf"
        _rigint.numberOfLines = 3
//        _left.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: UILayoutConstraintAxis.horizontal)
        
    }
    
    func setUpViews() {
        
        leftTitle = UILabel(frame: CGRect.zero)
        rightTitle = UILabel(frame: CGRect.zero)
        iconImage = UIImageView(image: UIImage(named: "Icon"))
        guard let _left = leftTitle,let _rigint = rightTitle, let _iconImage = iconImage else {
            return
        }
        _left.translatesAutoresizingMaskIntoConstraints = false
        _left.backgroundColor = .red
        _rigint.translatesAutoresizingMaskIntoConstraints = false
        _rigint.backgroundColor = .lightGray
        _iconImage.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(_left)
        self.contentView.addSubview(_rigint)
        self.contentView.addSubview(_iconImage)
    }
    
    
    func makeLayout() {
        guard let _left = leftTitle,let _rigint = rightTitle, let _img = iconImage else {
            return
        }
//        self.contentView.addConstraints(NSLayoutConstraint.constraints(
//            withVisualFormat: "H:|-10-[i(==40)]-10-[l]-10-|", options: [],
//            metrics: nil, views: ["i":_img,"l":_left]))
//
//        self.contentView.addConstraints(NSLayoutConstraint.constraints(
//            withVisualFormat: "V:|-10-[l]-10-[r]-10-|", options: [.alignAllLeading],
//            metrics: nil, views: ["l":_left,"r":_rigint]))
//
//        self.contentView.addConstraints(NSLayoutConstraint.constraints(
//            withVisualFormat: "V:|-(>=10)-[i(==40)]-(>=10)-|", options: [//.alignAllCenterX,
//                                                                         .alignAllCenterY], metrics: nil,
//            views: ["i":_img]))
        
        
        
        
//        self.contentView.addConstraints(NSLayoutConstraint.constraints(
//            withVisualFormat: "H:|-0-[i(==40)]-0-|", options: [],
//            metrics: nil, views: ["i":_img]))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-50-[l]-10-|", options: [],
            metrics: nil, views: ["l":_left]))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-50-[r]-10-|", options: [],
            metrics: nil, views: ["r":_rigint]))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-10-[l]-10-[r]-10-|", options: [],
            metrics: nil, views: ["l":_left,"r":_rigint]))
        
//        self.contentView.addConstraints(NSLayoutConstraint.constraints(
//            withVisualFormat: "V:[p]-(<=1)-[i]", options: [], metrics: nil,
//                                   views: ["p":self.contentView,"i":_img]))
        
//        [NSLayoutConstraint constraintWithItem:_img
//            attribute:NSLayoutAttributeCenterX
//            relatedBy:NSLayoutRelationEqual
//            toItem:view.superview
//            attribute:NSLayoutAttributeCenterX
//            multiplier:1.f constant:0.f];
        
        
//        self.contentView.addConstraints(NSLayoutConstraint.constraints(
//                        withVisualFormat: "V:[i(==40)]", options: [], metrics: nil,
//                                               views: ["i":_img]))
        
        self.contentView.addConstraints([
            NSLayoutConstraint(item: _img, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1.0, constant: 1.0),
            NSLayoutConstraint(item: _img, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40),
            NSLayoutConstraint(item: _img, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40),
            ])
    }
}

