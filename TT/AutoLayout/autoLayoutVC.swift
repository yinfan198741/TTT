//
//  autoLayoutVC.swift
//  SwiftTest
//
//  Created by 尹凡 on 4/8/18.
//  Copyright © 2018 尹凡. All rights reserved.
//

import Foundation

import UIKit

class autoLayoutVC: UIViewController, UITableViewDelegate , UITableViewDataSource {
    var tabview: UITableView?
    var cellfive: autoCellFive?
    var cellsix: autoCellSix?
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        tabview = UITableView(frame: CGRect.zero)
        guard let _tableview = tabview else {
            return
        }
        _tableview.delegate = self
        _tableview.dataSource = self
        _tableview.estimatedRowHeight = 40
        _tableview.rowHeight = UITableViewAutomaticDimension
        _tableview.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(_tableview)
        
        self.view.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[vt]|", options: [], metrics: nil, views: ["vt":_tableview]))
        self.view.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[vt]|", options: [], metrics: nil, views: ["vt":_tableview]))
      
//      let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self.view, action: <#T##Selector?#>)
//      tap.addTarget(self, action: #selector(sigTapd))
//      self.view.addGestureRecognizer(tap)
    
      
      
      
      let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                               action: #selector(tapGesAction))
      self.view.addGestureRecognizer(tap)
  }
  
  
   @objc func tapGesAction() {
    self.dismiss(animated: true, completion: nil)
  }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = autoCell()
            return cell
        case 1:
            let cell = autoCellTow()
            return cell
        case 2:
            let cell = autoCellThree()
            return cell
        case 3:
            let cell = autoCellFour()
            return cell
        case 4:
             self.cellfive = autoCellFive()
            return cellfive!
        case 5:
            self.cellsix = autoCellSix()
            return cellsix!
        case 6:
            return autoCellAutoSizefalse()
        case 7:
            return autoCellSeven()
        default:
             return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        switch indexPath.row {
            case 4:
           cellfive!.updateConst()
        case 5:
            self.cellsix!.updateConst()
        default: break
          
        }
        
    }
}

