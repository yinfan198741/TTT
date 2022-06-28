//
//  SwiftInit.swift
//  TT
//
//  Created by 尹凡 on 10/17/18.
//  Copyright © 2018 fanyin. All rights reserved.
//

import Foundation
import UIKit


internal class swiftInit: UIViewController {
  override func viewDidLoad() {
    let width = 100
    let b = Base(frame: CGRect(x: 10, y: 10, width: width, height: width))
    b.backgroundColor = .red
    self.view.backgroundColor = .white
    self.view.addSubview(b)
  }
}

class Base: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.initTest()
  }
  
//  convenience override init(frame: CGRect) {
//    self.init(frame: frame)
//  }
  
  
//  convenience init?(frame: CGRect) {
//    self.init(frame: frame)
//  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func initTest()  {
    // Works fine
//    let instanceA = ClassAA(array: [1, 2])
    // Compile error when override is added:
    // error: Initializer does not override a designated initializer from its superclass
    // note: attempt to override convenience initializer here
    //     convenience init(array: [T]) {
    //                 ^
//    let instanceB = ClassBB(array: [1, 2])
    
//    let aa = T(name: "aa")
//    let bb = T(name: nil)
    
    
    
    
//    print("aa =\(aa)")
//    print("bb =\(bb)")
    
    
    let a = T(N: "aa")
    a.aaa()
    
//    let a = A.init(string: "ok")
//    let b = B.init()
    
  }
}


class CClassA<T> {
  
  // This array would be private and not visible from ClassB
  var array: [T]?
  
  init() { }
  
  convenience init(array: [T]) {
    self.init()
    self.array = array
  }
}

class ClassB<T>: CClassA<T> {
  
  var anotherArray: [T]?
  
  // I feel like I should include the "override" keyword
  // but I get a compiler error when "override" is added before "convenience init".
  convenience init(array: [T]) {
    self.init()
    self.anotherArray = array
  }
}


struct T {
  var N:String
}

extension T {
  
  func aaa()  {
    print("aaaaaa")
  }
  
//  init?(_ name:String?) {
//    if let _n = name {
//      self.init(N: _n)
//    }
//  }
}



//private class AA {
//  init(string:String) {
//    print(string)
//  }
//}
//
//private class BB : AA {
//  var newVariable:String
//  
//  init() {
//    self.newVariable = "hello"
//    super.init(string: "aaaaa")
//  }
//}


