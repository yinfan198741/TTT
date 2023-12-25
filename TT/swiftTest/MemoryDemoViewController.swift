//
//  MemoryDemoViewController.swift
//  TT
//
//  Created by FYIN2 on 2023/5/29.
//  Copyright © 2023 fanyin. All rights reserved.
//

import UIKit


class MyClass {

    var doSomething: (() -> Void)?
    var doSomethingElse: (() -> Void)?

    var didSomething: Bool = false
    var didSomethingElse: Bool = false

    deinit {
        print("Deinit")
    }

    func printCounter() {
        print(CFGetRetainCount(self))
    }

    func doEverything() {
        print("start")
        printCounter()
        doSomething = { [weak self] in
            guard let self = self else { return }
            self.didSomething = true
            print("did something")
            self.printCounter()

            self.doSomethingElse = {
                self.didSomethingElse = true
                print("did something else")
                self.printCounter()
            }

            self.doSomethingElse?()
        }
        doSomething?()
        printCounter()
    }
    
    
//    func doEverything() {
//        print("start")
//        printCounter()
//        self.doSomething { [weak self] in
//            guard let self = self else { return }
//            self.didSomething = true
//            print("did something")
//            self.printCounter()
//
//            self.doSomethingElse {
//                self.didSomethingElse = true
//                print("did something else")
//                self.printCounter()
//            }
//        }
//        printCounter()
//    }
    
}



class MemoryDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        Test()
    }
    
    
   
    
    func Test() {
        let model = MyClass()
        model.doEverything()
    }

    deinit {
        print("MemoryDemoViewController")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
