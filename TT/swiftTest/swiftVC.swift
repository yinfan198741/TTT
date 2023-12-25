//
//  swiftVC.swift
//  TT
//
//  Created by 尹凡 on 9/13/18.
//  Copyright © 2018 fanyin. All rights reserved.
//

import Foundation
import UIKit
import Combine
//import SVProgressHUD

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

internal class swiftVC: UITableViewController {
    
    var source:[[String]]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.source = [
            ["propertyWarper","propertyWarper"],
            ["CombineRetry","CombineRetry"],
            ["FPRDemo","FPRDemo"],
            ["MemoryDemo","MemoryDemo"]
        ];
//        self.view.backgroundColor = UIColor.whiteColor;
        self.tableView.dataSource =  self;
        self.tableView.delegate = self;
        
//        _label = [[UILabel alloc] initWithFrame:CGRectMake(250,700, 200, 50)];
//        _label.backgroundColor = UIColor.redColor;
        
//        [self.view addSubview:self.label];
//        [self.tableView reloadData];
        self.tableView.reloadData()
        
        
        
//        let uiLable = UILabel.init()
//        uiLable.text = "uiLable"
//        uiLable.textColor = .red
//        uiLable.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
//        self.view.addSubview(uiLable)
//
//        let bt = UIButton(type: .system)
//        bt.backgroundColor = .blue
//        bt.setTitle("观察者", for: .normal)
//        bt.setTitleColor(.red, for: .normal)
//        bt.addTarget(self, action: #selector(buttonAdavaceSwift), for: .touchUpInside)
//        bt.frame = CGRect(x: 10, y: 200, width: 100, height: 100)
//        self.view.addSubview(bt)
//        self.addTabDiss()
        
    }
    
    
    @objc
    func buttonAdavaceSwift() {
        NSLog("%@", "buttonAdavaceSwift")
        let adavaceSwift = myAdavaceSwift()
        adavaceSwift.TestArray()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.source?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = UITableViewCell.init()
        cell.textLabel?.text = (self.source![indexPath.row]).first
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let method = (self.source![indexPath.row]).first
//        self.perform(#selector(method))
        self.perform(Selector.init(stringLiteral: method!))
    }
    
//    @UserDefaultBack<String>(Key: "Name" , defaultVaule: "abc")
//    @UserDefaultBack(defaultVaule: "abc", Key: "Name")
    @UserDefaultBack(Key: "Name")
    var name: String = "abc"

    
//    @UserDefaultBack(Key: "Name2")
    @UserDefaultBack(wrappedValue: nil, Key: "Name2")
    var name2: String?
    
    
    @UserDefaultBack(Key: "Name2")
    var name3: String?
    
//    @UserDefaultBack<Int>(Key: "Name" , defaultVaule: 123)
//    var name2: Int?
    
    @Capitalized
    var big: String?
    
    @objc
    func propertyWarper() {
        print("propertyWarper Test")
        name = "abcd"
        self.name3 = nil
        print("self.name2 = \(self.name2)")
        print("self.name3 = \(self.name3)")
        
        print("$self.name2 = \(self.$name2)")
        
        
        print("big1 = \(big)")
        big = "big"
        print("big2 = \(big)")
        
        
        @Capitalized var big3: String?
        big3 = "abcd"
        print("big3 = \(big3)")
        
        
//        do {
//            let personJson =
//            """
//                {"name":null,"money":null,"skills":null,"teachers":null}
//            """
//            let person = try JSONDecoder().decode(PropertyPerson.self, from: personJson.data(using: .utf8)!)
//            print(person)
//        } catch  {
//            print(error)
//        }
        
        WarpTest()
    }
    
    var cancellables = Set<AnyCancellable>()
    
    @objc
    func CombineRetry() {
        print("CombineRetry")
        let comPub = combieRetryPublisher()
        
        combieRetryPublisher()
            .handleEvents(
                receiveSubscription: { sub in
                    SVProgressHUD.show()
                },
                receiveCompletion: { com in
                    print("com = \(com)")
                    SVProgressHUD.dismiss()
                }
            )
        .sink { e in
            print("e = \(e)")
        } receiveValue: { value in
            print("value = \(value)")
        }.store(in: &cancellables)

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
    @objc
    func MemoryDemo() {
        print("MemoryDemo")
        let memory = MemoryDemoViewController.init()
        self.showDetailViewController(memory, sender: nil)
    }
    
}
