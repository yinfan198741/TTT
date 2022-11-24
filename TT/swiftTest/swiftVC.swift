//
//  swiftVC.swift
//  TT
//
//  Created by 尹凡 on 9/13/18.
//  Copyright © 2018 fanyin. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    func addTabDiss()  {
//        let sigtap = UITapGestureRecognizer(target: self, action:#selector(sigTap))
//        self.view.addGestureRecognizer(sigtap)
    }
    
    func sigTap()  {
        print("sigTap")
        self.dismiss(animated: true)
    }
}

internal class swiftVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let uiLable = UILabel.init()
        uiLable.text = "uiLable"
        uiLable.textColor = .red
        uiLable.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        self.view.addSubview(uiLable)
        
        let bt = UIButton(type: .system)
        bt.backgroundColor = .blue
        bt.setTitle("观察者", for: .normal)
        bt.setTitleColor(.red, for: .normal)
        bt.addTarget(self, action: #selector(buttonAdavaceSwift), for: .touchUpInside)
        bt.frame = CGRect(x: 10, y: 200, width: 100, height: 100)
        self.view.addSubview(bt)
        self.addTabDiss()
    }
    
    
    @objc
    func buttonAdavaceSwift() {
        NSLog("%@", "buttonAdavaceSwift")
        let adavaceSwift = myAdavaceSwift()
        adavaceSwift.TestArray()
    }
    
    func buttonTap() {
        print("buttonTap")
        
//        let a:Int? = 5
//        a.map { Int? -> Int in
//            return $0
//        }
//
//        print(b)
//        let obvTest = ObserverTest()
//        obvTest.Test()
        
//        let avatarURL: String? = "http://blog.liushuaiko.be/images/avatar.PNG"
//        if let _avatarURL = avatarURL {
//            if let url = NSURL(string: _avatarURL) {
//                print(url.absoluteString)
//            }
//        }
//
//        let c = avatarURL.map {
//            return $0
//            }.map{
//            return $0
//        }
//
//        print(c)
//        let d = avatarURL.flatMap{
//            return NSURL(string: $0)
//            }.flatMap {
//                return $0?.absoluteString
//        }
//        print(d)
        
//        let d:Int = 5
//
        let a:Int? = 5
        let b = a.map { val -> Int in
            return val
        }
        print(b)

//        let d = a.map {
//            return nil
//        }

       let c = a.flatMap { val -> String? in
            print("val = \(val)")
            return "\(val)"
        }
       print("c = \(c)")

    }
    
    func aaaa() -> String? {
        return "a"
    }
    
//    map(transform:warp->u)->u?
//    {
//    switch self {
//    case let (y) {
//       return option(transform(y))
//    }
//    }
//    }
    
//    flatmap(transform:warp->u?)->u?
//    {
//    switch self {
//    case let (y) {
//       return (transform(y))
//    }
//    }
//    }
    
}
