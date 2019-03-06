//
//  autoCellFive.swift
//  SwiftTest
//
//  Created by 尹凡 on 4/10/18.
//  Copyright © 2018 尹凡. All rights reserved.
//

import Foundation

import UIKit

class autoCellFive:  UITableViewCell {
    
    var leftTitle: UILabel?
    var rightTitle: UILabel?
    var iconImage: UIImageView?
    
    var cons_image_width:NSLayoutConstraint?
    var cons_image_height:NSLayoutConstraint?
    
    var ani:Bool = false
    
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
        _rigint.text = "abcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcasdjflasjdfasjdflajsl;fjalsjdfaslkdjflasdjlf"
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
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-[i]-10-[l]-10-|", options: [],
            metrics: nil, views: ["i":_img,"l":_left]))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-[i]-10-[r]-10-|", options: [],
            metrics: nil, views: ["i":_img,"r":_rigint]))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-10-[l]-10-[r]-10-|", options: [],
            metrics: nil, views: ["l":_left,"r":_rigint]))
        
        
        cons_image_width = NSLayoutConstraint(item: _img, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40)
        
        cons_image_height = NSLayoutConstraint(item: _img, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40)
        
        
        
        self.contentView.addConstraints([
            NSLayoutConstraint(item: _img, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1.0, constant: 1.0),
            cons_image_width!,cons_image_height!]
            )
        
    }
    
   public func updateConst() {
        
        guard let _left = leftTitle,let _rigint = rightTitle, let _img = iconImage else {
            return
        }
        ani = !ani
        var w_h:CGFloat = 0
        w_h = ani == true ? 100 :40
        self.contentView.layoutIfNeeded()
        UIView.animate(withDuration: 5) {
            self.cons_image_width?.constant = w_h
            self.cons_image_height?.constant = w_h
            self.contentView.layoutIfNeeded()
        }
    }
}
