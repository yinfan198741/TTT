//
//  enumTest.swift
//  SwiftTest
//
//  Created by 尹凡 on 3/4/18.
//  Copyright © 2018 尹凡. All rights reserved.
//

import Foundation
import UIKit




enum Trade {
//    let info: String = "info"
    case Buy (name: String , count: Int)
    case Sell (name: String , count: Int)
}

enum person: String {
    
    enum age {
        case little
        case middle
        case big
    }
    
    case china = "china"
    case usa = "usa"
    case jpa = "jap"
}

enum IOSDeivces: CGSize {
    case iphone6sp = "{400,400}"
}

struct car {
    enum type {
        case truck
        case bus
    }
    let carType: type
}

class carC {
    var carType: car.type?
}


enum Wearable {
    enum Weight: Int {
        case Light = 1
    }
    enum Armor: Int {
        case Light = 2
    }
    case Helmet(weight: Weight, armor: Armor)
    func attributes() -> (weight: Int, armor: Int) {
        switch self {
        case .Helmet(let w, let a): return (weight: w.rawValue * 2, armor: w.rawValue * 4)
        }
    }
}

//extension CGSize : StringLiteralConvertible{
//    
//    public typealias StringLiteralType = CGSize
//
//
//}


//extension CGSize: ExpressibleByStringLiteral {
//    public init(stringLiteral value: String) {
//        let size = CGSizeFromString(value)
//        self.init(width: size.width, height: size.height)
//    }
//
//    public init(extendedGraphemeClusterLiteral value: String) {
//        let size = CGSizeFromString(value)
//        self.init(width: size.width, height: size.height)
//    }
//
//    public init(unicodeScalarLiteral value: String) {
//        let size = CGSizeFromString(value)
//        self.init(width: size.width, height: size.height)
//    }
//}


extension CGSize: ExpressibleByStringLiteral {
    
   public typealias StringLiteralType = String
    
    public init(stringLiteral value: CGSize.StringLiteralType) {
        let size = CGSizeFromString(value)
        self.init(width: size.width, height: size.height)
    }
}

class ClassA {
    
    static let instance = ClassA(num: "a")
    
    var numA: String

    init(num: String) {
        numA = num
    }
}

struct structA {
    var sA: String
    var sB: String?
    init(sa: String) {
        sA = sa
    }
    func addTo(adder: Int) -> ((Int) -> Int) {
        return {
            num in
            return num+adder
        }
    }
    
    func addNumber(p:Int) -> ((Int)-> Int) {
        func add(pp:Int) -> Int {
            return p + pp
        }
        return add
    }
    
    
//    func printString() -> (Int) -> Bool {
//        return num > 0 ? true : false
//    }
    
    
    func T_int(d:Int) -> Int {
        return d + 1
    }
    
    func test() {
        
        let first = addNumber(p: 10)
        let second = first(5)
        print(second)
        
        let addTwo = addTo(adder:2)    // addTwo: Int -> Int
        let result = addTwo(6)   // result = 8
        print(result)
        
        
        
        let func_a: ((Int)-> Int) = { (d:Int) -> Int in
            return d + 1
        }
        
//        let func_a: ((Int)-> Int) = T_int
        
        let a_x = func_a(5)
        print(a_x)
        
        TTTS()
        TTAddress()
        
        TestRac()
        
//        let f = printString()
//        let b = f(0)
//        print(b)
        
//        let a = printString()
//        let a_b = a("a")
//
//        let b = printString("print A")
//        let c = printString("print B") { (C: String) -> Bool in
//            print(C)
//            return false
//        }
//        printString { (D: String) in
//            print(D)
//        }
//        printFunc {
//            print("func")
//        }
        
    }
    
    
    
    
    func TTTS() {
        var arr = [1, 2, 3]
        //map函数是有返回值的，想要arr里面的值map过去需要arr重新接收新值
        let arr_m = arr.map { (a : Int) -> Int in
            return a * 2
        }
        
        _ = arr_m.map { (i) in
            print(i)
        }
        
        //这种写法只是尾随闭包的简写。。
       let arr_p = arr.map {
            $0 * 2
        }
        
        _ = arr_p.map { (i) in
            print(i)
        }
    }
    
    
    
    func TTAddress() {
        let a = 1
        let b = 2
        let a_d = memoryAddress(a)
        let b_d = memoryAddress(b)
        print(a_d,b_d)
        
    }
    
    let memoryAddress: (Any) -> String = {
        guard let cVarArg = $0 as? CVarArg else { return "Can not find memory address" }
        return String(format: "%p", cVarArg)
    }
    
    
    /// 参+返回值
    func printString(_ A: String) -> Bool {
        print(A)
        return true
    }
    /// 普通参数 + 函数参数 - 返回值
    func printString(_ B: String, f: (String) -> Bool) -> Bool {
        print(B)
        return f("func f string is " + B)
    }
    /// 无参 - 函数返回值
    func printString() -> (String) -> Bool {
        return printString
    }
    /// 函数参 - 无返回值
    func printString(f: (String) -> ()) {
        f("hehe")
    }
    /// 闭包中执行的函数参数(逃逸闭包)
    func printFunc(f: @escaping () -> ()) {
        printString { _ in
            f()
        }
    }
    
    
    func fetchUser(with id: Int, completion: @escaping ((String) -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
            let user = "jewelz"
            completion(user)
        }
    }
    
    

    
    func TestRac() {
//        fetchUser(with: 12345).subscribe({_ in
//
//        })
    
//        let signal = Signal()
//        signal.subscribe { result in
//            print(result)
//        }
//
//        signal.send(.success(100))
//
//
        let (send, signal) = Signal.empty()
        signal.subscribe { result in
            print(result)
        }
        
        send(.success(100))
        
//        signal.send(.success(100))
//        signal.send(.success(200))
//
        // Print
//        success(100)
//        success(200)
    }
    
//    func fetchUser(with id: Int) -> Signal {
//
//    }
}


enum Result {
    case success(Int)
    case message(String)
    case error(Error)
}




final class Signal {
    fileprivate typealias Subscriber = (Result) -> Void
    fileprivate var subscribers: [Subscriber] = []
    func send(_ result: Result) {
        for subscriber in subscribers {
            subscriber(result)
        }
    }
    func subscribe(_ subscriber: @escaping (Result) -> Void) {
        subscribers.append(subscriber)
    }
    
    static func empty() -> ((Result) -> Void, Signal) {
        let signal = Signal()
        return (signal.send, signal)
    }
//    fileprivate func send(_ result: Result) {  }
    
}






extension UITextField {
    var signal: Signal {
        let (sink, signal) = Signal.empty()
        
        let observer = KeyValueObserver(object: self, keyPath: #keyPath(text)) { str in
            sink(.message(str))
        }
//        signal.objects.append(observer)
        return signal
    }
}


final class KeyValueObserver<T>: NSObject {
    
    private let object: NSObject
    private let keyPath: String
    private let callback: (T) -> Void
    init(object: NSObject, keyPath: String, callback: @escaping (T) -> Void) {
        self.object = object
        self.keyPath = keyPath
        self.callback = callback
        super.init()
        object.addObserver(self, forKeyPath: keyPath, options: [.new], context: nil)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let keyPath = keyPath, keyPath == self.keyPath, let value = change?[.newKey] as? T else { return }
        callback(value)
    }
    deinit {
        object.removeObserver(self, forKeyPath: keyPath)
    }
}















