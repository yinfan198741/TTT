//
//  perfTest.swift
//  SwiftTest
//
//  Created by 尹凡 on 4/1/18.
//  Copyright © 2018 尹凡. All rights reserved.
//

import Foundation


struct OrdinaryStruct {
//    let classField: SomeClass
}


//public  class OnDelete {
//
//    var block: () -> Void
//
////    public init(_ c:() -> Void) {
////        block = c
////    }
//
//
////    convenience init(c:Int) {
////        self.init()
////    }
//
//
////    convenience initClo(c:() -> Void) {
////        self.init()
////        block = c
////    }
//
//    deinit {
//        block()
//    }
//}


struct Pig {
    private var count = 4   //8字节
    var name = "Tom"        //24字节
    
    //返回指向 Pig 实例头部的指针
    mutating func headPointerOfStruct() -> UnsafeMutablePointer<Int8> {
        return withUnsafeMutablePointer(to: &self) {
            return UnsafeMutableRawPointer($0).bindMemory(to: Int8.self, capacity: MemoryLayout<Pig>.stride) }
    }
    
    func printA() {
        print("Animal a:\(count)")
    }
}


struct pointerTest {
    
    
    func aaa(){
        var pig = Pig()
        let pigPtr: UnsafeMutablePointer<Int8> = pig.headPointerOfStruct()   //头指针， 类型同const void *
        //有了头指针，还需要知道每个变量的偏移位置和大小才可以修改内存
        let rawPtr = UnsafeMutableRawPointer(pigPtr)    //转换指针 类型同void *
        
        let aPtr = rawPtr.advanced(by: 0).assumingMemoryBound(to: Int.self)   //advanced函数时字节偏移，assumingMemoryBound是内存大小
        print("修改前：\(aPtr.pointee)")   //4
        pig.printA()  //count等于4
        aPtr.initialize(to: 100)    //将count参数修改为100，即篡改了私有成员
        print("修改后：\(aPtr.pointee)")   //100
        pig.printA()
    }
}
    
//  static func Test() {
//    if  let state = resp.entity {
//        let params =
//        "?bizlogintoken=\(Client.loginToken() ?? "")"
//        +"&version=\(backgroundVersion())"
//        +"&\(Config.Network.nativeVersion())"
//
//    }
//
//    func loginToken() -> String
//    {
//        return "aa"
//    }
//    func backgroundVersion()() -> String {
//    reutrn "vv"
//    }
//}
