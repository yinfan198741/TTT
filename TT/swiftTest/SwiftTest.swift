//
//  SwiftTest.swift
//  TT
//
//  Created by fanyin on 2018/8/6.
//  Copyright © 2018 fanyin. All rights reserved.
//

import Foundation
import UIKit


typealias action = () -> Void



internal class  MyTabviewVC: UITableViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  
  private var source:[(String , action)] = []
  
  override func viewDidLoad() {
    source.append(("Optional", self.Optional))
    source.append(("Init", self.initTest))
    source.append(("Map_array", self.arrayMapTest))
    source.append(("arrayFilterTest", self.arrayFilterTest))
    source.append(("Reduce", self.arrayReduce))
    source.append(("protoloverride", self.protoloverride))
    source.append(("imageChooser", self.imageChooser))
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return source.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    cell.textLabel?.text = source[indexPath.row].0
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    source[indexPath.row].1()
    
  }
  
  func Optional() {
    print("Optional")
    
    let s: String? = "abc"
    //返回一个问号
    let _v = s.flatMap { (a: String) -> Int? in
      return Int(a)
    }
    
    //map 返回两个问号
    let _v1 = s.map { (a: String) -> Int? in
      return Int(a)
    }
    
    print("v = \(_v) v1 = \(_v1)")
    
    
    let v1: String? = "abc"
    //这种返回了两个问号，不好操作了，map外层还会加问号
    let v1_map = v1.map { item -> Bool? in
      if item == "abc" {
        return true
      }
      return nil
    }
    let v2_map = v1.flatMap { item -> Bool? in
      if item == "abc" {
        return true
      }
      return nil
    }
    
    print("v1 = \(v1_map)")
    print("v2 = \(v2_map)")
    
    let value:String? = "a"
    let result = value.map { Int($0)}
    print(result)
    
    let result2 = value.flatMap { Int($0)}
    print(result2)
  }
  
  func initTest() {
    print("initTest")
    self.present(swiftInit(), animated: true)
  }
  

  func protoloverride() {
    let aa = ClassAA(aa: 19)
    let bb = ClassBB(aa: "100")
    print(aa);
    print("\(type(of: bb.a as Int))\(bb.a as Int)");
    print("\(type(of: bb.a as String))\(bb.a as String)");
     print(bb.a);
//    print("\(type(of: bb.a))\(bb.a)");
//    print("\(type(of: bb.a as! Double))\(bb.a as! Double)");
  }
  
  func imageChooser() {
//    let chooser = ImagePickerHelper()
//    chooser.chooseImage(rootVc: self);
    
//    let imgController = UIImagePickerController()
//    imgController.sourceType = .camera
//    imgController.allowsEditing = false
//
//    imgController.delegate = self
//    self.present(imgController,
//                   animated: true,
//                   completion: nil)
    
    let vc = ImageViewVC()
    self.present(vc, animated: true)
  }
  
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
    picker.delegate = nil
    picker.dismiss(animated: false)
    if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
//      selectedImage = image
    }
  }
  
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.delegate = nil
    picker.dismiss(animated: false)
  }
  
  
  func arrayReduce() {
    let array: [String?] = ["AA", nil, "BB", "CC"];
    
   let res = array.enumerated().reduce("Start") { (Result, item) -> String in
    let (offset, element) = item
//      print("offset = \(value.offset) element = \(value.element)")
//    return  Result"—— "\(offset)" +"  "+ (element ?? "nil")
    return "\(Result) —— \(offset) - \(element ?? "nil element")"
    }
    print("res = \(res)")
    
//
//    array.enumerated().reduce("aaa") { (result,  let (x,y)) -> String in
//    }
    
//    array.enumerated().reduce("Start") { (Result, (X ,Y)) -> Result in
//
//    }
    
//    array.enumerated().reduce("start") { (Result, (x ,y in  {
//
//      } )) -> Result in
//
//    }
    
   let res1 = array.reduce("start") { (Result, item) -> String in
    if let  _item = item {
      return Result+" "+_item
    }
    return Result
    }
    print("res = \(res1)")
    
    
  }
  
  func arrayFilterTest() {
    let array: [String?] = ["AA", nil, "BB", "CC"];
    let filterA = array.filter { (item) -> Bool in
      if item == nil
      {
        return false
      }
      return true
    }
    let filterB = filterA.compactMap { $0 }
    print("filterA = \(filterB)")
    
    
    let filterC =  array.compactMap { $0 }
    print("filterC = \(filterC)")
    
  }
  
  func arrayMapTest() {
    
    var values = [1,3,5,7]
    let results = values.map ({ (element) -> Int? in
      return element * 2
    })
    print("results = \(results)")
    
    let results1 = values.flatMap ({ (element) -> Int? in
      return element * 2
    })
    print("results1 = \(results1)")
    
    let optionalArray: [String?] = ["AA", nil, "BB", "CC"];
//    let rsA = optionalArray.map {
//       Int($0!)
//    }
//
//    let rsB = optionalArray.flatMap {
//      Int($0!)
//    }
    
    let optionalResult1 = optionalArray.map { (item) -> String? in
      print("item = \(item)")
      return item
    }
    print("map= \(optionalResult1)" )
    
    
    let optionalResult3 = optionalArray.compactMap { (item) -> String? in
      return item
    }
    print("flatMap= \(optionalResult3)")
    
    
    let numbersCompound = [[1,2,3],[4,5,6]];
    let res = numbersCompound.map { $0.map{ $0 + 2 } }
    print("map Result = \(res)")
    
    let res2 = numbersCompound.flatMap{ $0.map{ $0 + 2 } }
    print("flatMap Result = \(res2)")
    
    //      let optionalArray2: [[Int]] = [[1,2,3],[4,5,6]];
    
    //      let optionalResult21 = optionalArray2.map { (item) -> [Int] in
    //        return  item * 2
    //      }
    //    let optionalResult21 = optionalArray2.map {$0 * 2}
    //    let optionalResult22 = optionalArray2.flatMap { $0 + 2}
  }
  
  class C {}
  let values: [Any]! = [C()]
  
  func mapImpile() {
    let transformed = values.map { $0 as! C }
  }
  
  func test() throws -> Int! {
    return 1
  }
  
  func TestiOU()  {
    if let x = try? test() {
      //let y: Int = x    // error: x is an Int?
      //print("y1 = \(y)")
    }
    
    if let x: Int = try? test() { // explicitly typed as Int
      let y: Int = x    // okay, x is an Int
      print("y2 = \(y)")
    }
    
    if let x = try? test(), let y = x { // okay, x is Int?, y is Int
      
    }
  }
  
  func OptionalRet_Q() -> Int? {
    let transformed = values.map { $0 as! C }
    return nil
  }
  
  func OptionalRet_T() -> Int! {
    return nil
  }
}

func changeC() {
  typealias privateMethodAlias = @convention(c) (Any) -> UIImage? // 1
  //    let originalImageFunction = unsafeBitCast(sym, to: privateMethodAlias.self) // 2
  //    let originalImage = originalImageFunction(imageGenerator) // 3
  //    self.imageView.image = originalImage // 4
}




//public func flatMap<S : SequenceType>(
//  transform: (${GElement}) throws -> S
//  ) rethrows -> [S.${GElement}] {
//    var result: [S.${GElement}] = []
//    for element in self {
//      result.appendContentsOf(try transform(element))
//    }
//    return result
//}
//
//数组flatMap
//public func flatMap<T>(
//  @noescape transform: (${GElement}) throws -> T?
//  ) rethrows -> [T] {
//  var result: [T] = []
//  for element in self {
//                        过滤Nil
//    if let newElement = try transform(element) {
//      result.append(newElement)
//    }
//  }
//  return result
//}

/// If `self == nil`, returns `nil`.
/// Otherwise, returns `f(self!)`.
//public func map<U>(@noescape f: (Wrapped) throws -> U)
//  rethrows -> U? {
//    switch self {
//    case .Some(let y):
//      return .Some(try f(y))
//    case .None:
//      return .None
//    }
//}
//
///// Returns `nil` if `self` is `nil`,
///// `f(self!)` otherwise.
//@warn_unused_result
//public func flatMap<U>(@noescape f: (Wrapped) throws -> U?)
//  rethrows -> U? {
//    switch self {
//    case .Some(let y):
//      return try f(y)
//    case .None:
//      return .None
//    }
//}



protocol TestA {
  var a: Int { get }
}

protocol TestB : TestA {
//   var a: Int { get }
   var a: String { get }

}

extension TestB {
  var a: Int {
    return Int(self.a) ?? -1
  }
}

class ClassAA: TestA {
  let a: Int
  init(aa: Int) {
    self.a = aa
  }
}

class ClassBB: TestB {
  
  init(aa: String) {
    
    self._a = aa;
  }
  var _a: String
  
  var a: String {
    get{
      return _a
    }
    set {
      _a = newValue
    }
  }
//  var tg:[TestG: where A == Int]?
//  var tg:[TesgGG]
}


protocol TestGT {

}
protocol NTestG {
  var aType:Int { get }
}

protocol TestG {
  associatedtype A
}

protocol TesgGG : TestG where A == Int{
  
}

struct TestGGS : TestG {
  typealias A = Int
}


struct PersonTest {
  let first: String
//  var last: Observable<String>
}

