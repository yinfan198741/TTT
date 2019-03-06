//
//  sstest.swift
//  SwiftTest
//
//  Created by 尹凡 on 4/4/18.
//  Copyright © 2018 尹凡. All rights reserved.
//

import Foundation





//protocol Observable {
//    associatedtype T
//}
//
//struct People: Observable {
//    typealias T = String
//    var name: String
//    var age: Double
//
//
//}
//
//struct Color: Observable {
//     typealias T = Int
//    var red: Double, green: Double, blue: Double
//
//
//}
//
//var observers = [Observable]()


protocol Observable {
    associatedtype T
    func map<O : Observable>(function : (T) -> O.T) -> O
    func zip<O : Observable, R: Observable>(other : O) -> R where R.T == (T, O.T)
    
    //Placed here to write default implementaions
    init(value: T)
    var value: T {get}
}
extension Observable {
    func map<O : Observable>(function: (T) -> O.T) -> O {
        return O(value: function(self.value))
    }
    func zip<O : Observable, R: Observable>(other : O) -> R where R.T == (T, O.T) {
        return R(value: (self.value, other.value))
    }
}
//class ObservableImpl<T>: Observable {
//    var value: T
//    required init(value: T) {
//        self.value = value
//    }
//}
//struct AnotherObservableImpl<T>: Observable {
//    var value: T
//    init(value: T) {
//        self.value = value
//    }
//}
//let observableInt = ObservableImpl<Int>(value: 1)
////let observableDouble = observableInt.map(Double.init) //Causes error
//let observableDouble: ObservableImpl = observableInt.map(function: Double.init)
//let anotherObservableDouble: AnotherObservableImpl = observableInt.map(function: Double.init)
//let zippedObservable: ObservableImpl = observableInt.zip(other: observableDouble)




func printGenericInfo<T>(_ value: T) {
//    let type = type(of: value)
    let t = type(of: value)
    print("'\(value)' of type '\(t)'")
}

protocol P {}
extension String: P {}



func betterPrintGenericInfo<T>(_ value: T) {
//    let type = type(of: value as Any)
//    print("'\(value)' of type '\(type)'")
    let va = value as Any
    print("va = \(va)")
    let vb = value as AnyObject
    print("vb = \(vb)")
    let t = type(of: va)
    print("'\(value)' of type '\(t)'")
    
    let tb = type(of: vb)
    print("'\(value)' of type '\(tb)'")
}


protocol Copyable {
     func copy() -> Self
//    func clamp(intervalToClamp: Self) -> Self
}


class C : Copyable {
    
    var a:Int = 5
    
    func copy() -> Self  {
        let ty =  type(of: self)
        let res = ty.init()
        res.a = 5
        return res
    }
    
    
    class func copyS() -> Self {
        print("aaa \(type(of: self))")
        let st = type(of: self)
       return self.init()
    }
    
    required init() {
    }
    
//    func getA(aa: Self) -> Int{
//        return 5
//    }
    
}

//struct AS : Copyable {
//    func copy() -> Self {
//
//    }
//}


extension A {
    class func calssFuncs() -> Self {
        let type = self
        print(type)
        let result = type.init()
        return result
    }
}

class A: Copyable {
     func copy() -> Self {
        
     let res = type(of: self).init()
        return res
//        return self
//        let ty = self.Self
//        return ty()
//        let ty = Self.type
//        return ty()

    
//       let t = type(of: A)
//        t.init()
//
//       let result  =  type(of: A).init()
//        return result
    }
    
    var num = 1
    
    required init() {
        
    }
    
//    func copy() -> Self {
////        let type = type(of: self)
////        print(type)
////        let result = type.init()
////        result.num = num
////        return result
//    }
    
    func clamp(intervalToClamp: A) -> Self {
        let result = type(of: self).init()
        result.num = num
        return result
    }
    
    class func calssFunc() -> Self {
        let type = self
        print(type)
        let result = type.init()
        return result
    }
    
}

class B: A {
    func clamp(intervalToClamp: B) -> Self {
        let result = type(of: self).init()
        result.num = num
        return result
    }
}


//extension String {
//    class func calssFunc() -> Self{
//        return "aaa"
//    }
//}

struct testSelf {
    
    
    //    func AnyObject(tp: AnyObject.Type) -> Bool {
    ////        if tp === Int.Type {
    ////
    ////        }
    //    }
    
    
    func intType() -> Int.Type {
        return Int.self
    }
    
//    func intType() -> Int {
//        return Int.self
//    }
    
    func tests() {
        var t = self.intType()
        var arr = Array<Int.Type>() // Error: "'t' is not a type". Uh... yeah, it is.
    }
    
    
   static func test()  {
    
   let c =  C()
    
   let d = c.copy()
   d.a = 6
   print(c.a )
   print(d.a )
    let ct = type(of: c)
   let ctt = type(of: ct)
    print("ct \(ct) ctt \(ctt)")
//    print(type(of: c))
   let f =  C.copyS()
    print(f.a)
    
    
//    let type = A.self
//    let _ty = A.Type.self
//    let a = A()
//   let  b = a.copy()
//   let c = a.self


   
//    let ts =  type(of: s)
//    let tf = type(of: A.Type)
//    let tfa = type(of: )

    
    print("asdfa")
    
    
//    let int_A:Int = 5;
//    let typeof_int_A =  type(of: int_A)
//    let int_self = Int.self
//    let intType: Int.Type = Int.self
//
//    print("typeof_int_A == intType \(typeof_int_A == intType)")
//    print("int_self == intType     \(int_self == intType)")
//
//    let typeof_int = type(of: Int.self)
//    let typeof_int_int =  type(of: typeof_int)
//    let typeof_int_int_int =  type(of: typeof_int_int)
//    let int_A_self = int_A.self
//
//    print("""
//        int_self = \(int_self) intType = \(intType) typeof_int = \(typeof_int)
//        typeof_int_int = \(typeof_int_int) typeof_int_int_int = \(typeof_int_int_int) int_A_self = \(int_A_self)
//        """)
//
//
//    let typeof_int_self = type(of: int_self)
//
//    let eq0 = typeof_int == typeof_int_self
//    print("typeof_int == typeof_int_self \(eq0)")
//
//    let eq = typeof_int_int_int == typeof_int_int
//    print("typeof_int_int_int == typeof_int_int \(eq)")
//    let eq1 = typeof_int == int_self
//    print("typeof_int == int_self \(eq1)")
//    let cc = Int.Type
    
    
    
    
//    let tp_init = tp_String_self.init()
//    print("tp_init = \(tp_init)")

//        let st = type(of: s)
//        let sst = String.self
//        let ss = s.self
//
//       let ssta =  sst.init("bbb")
//
//        let typeB = B.self
//        typeB.calssFunc()
//
//        let objectA = A()
//        objectA.num = 100
//
//        let newObjectA = objectA.copy()
//        objectA.num = 1
//
//        let objectB = B()
//        objectB.num = 100
//        let newB = objectB.copy()
    
    
    
    let stringInstance = "aaaa"
    
    let tp_stringInstance_self = type(of: stringInstance.self)
    
    let String_self = String.self
    
    print("tp_stringInstance_self \(tp_stringInstance_self) String_self= \(String_self)")
    
    print("tp_stringInstance_self == String_self \(tp_stringInstance_self == String_self)")
    
    let string_self_init = String_self.init("abcd")
    print("string_self_init \(string_self_init)")
    
    let tp_String_self = type(of: String.self)
    print("tp_String_self \(tp_String_self)")
    
    
    
    let typeof_p = type(of: P.self)
    print("typeof_p = \(typeof_p)")
    
    
    
    let stringAsP: P = "Hello!"
    
    printGenericInfo(stringAsP)
    
    betterPrintGenericInfo(stringAsP)

    
    testGeneric()
    
    var songs = ["Shake it Off", "You Belong with Me", "Back to December"]
   let ass =  type(of: songs)
    print("ass= \(ass)")
    
    }
    
  
}



func testGeneric() {
//    generic<String>("Hello")
}

//func generic<T>(parameter: AnyObject) -> Bool {
//    if parameter is T {
//        return true
//    } else {
//        return false
//    }
//}


//protocol GenericProtocol {
//
//    typealias ReturnType
//
//    func doSomething() -> ReturnType
//
//}
//
//struct StringReturn : GenericProtocol {
//
//    func doSomething() -> String {
//        return "first"
//    }
//
//}
//
//struct AnotherStringReturn : GenericProtocol {
//
//    func doSomething() -> String {
//        return "another"
//    }
//
//}

//func build<T : GenericProtocol>(param: String) -> T where T.ReturnType == String {
//
//    if ..{
//        return StringReturn()
//        } else {
//        return AnotherStringReturn
//    }
//
//}


