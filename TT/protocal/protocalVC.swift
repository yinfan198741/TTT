//
//  protocalVC.swift
//  SwiftTest
//
//  Created by 尹凡 on 5/8/18.
//  Copyright © 2018 尹凡. All rights reserved.
//

import Foundation
import UIKit

class protocalVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.setTitle("protocal", for: .normal)
        button.addTarget(self, action: #selector(bt), for: .touchUpInside)
        button.backgroundColor = .red
        self.view.addSubview(button)
    }
    
    @objc func bt() {
//        print("bt print")
//        GenericTest()
        
        
        let str = "retailadmin://erp.retail/scan_barcode?type=normal&title=扫码"
        let stre = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let _url = "retailadmin://erp.retail/scan_barcode?type=normal"
        let param = "title"
        guard let url = URLComponents(string: stre!) else { return  }
        let  a  = url.queryItems?.first(where: { $0.name == param })?.value
        print(a!.removingPercentEncoding)
        
//        var t = Test()
//        var b1 = Bar(va:"aaa")
//        var b2 = Bar(va:"bbb")
//        t.list = [b1 , b2]
//        t.logBar()
    }
    
    
    func handleResult(result: GResult<Box<String>>){
        switch result {
        case GResult.Success(let box):
            print(box)
        default:
            break
        }
    }
    
    func GenericTest() {
        self.handleResult(result: GResult.Success(Box(va: "hello")))
    }
    
    func protoTest() {
        var p = MyPerson()
        p.idNumber = "asdfasdfasdf"
        p.height = 31
        _ = p.getName()
        _ = p.getGender()
        _ = p.describe()
        print(p.idNumber)
        print("afdas")
    }
    
}
