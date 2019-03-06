//
//  protocalTest.swift
//  SwiftTest
//
//  Created by 尹凡 on 5/8/18.
//  Copyright © 2018 尹凡. All rights reserved.
//

import Foundation

protocol PersonProtocol {
    var height: Int? {get set}
    func getName()  -> String
    func getGender() -> String
}

extension PersonProtocol {
    
    func getName()  -> String {
        print("getName proto")
        return "getName proto"
    }
    
    func getGender() -> String {
        print("girl")
        return "girl"
    }
    
    func describe()  {
        let str = self.getGender()
        let name = self.getName()
        print("info = gender=\(str) name = \(name)")
    }
}

private var PERSON_ID_NUMBER_PROPERTY = 0

extension PersonProtocol {
    var idNumber: String {
        get{
            var result = objc_getAssociatedObject(self, &PERSON_ID_NUMBER_PROPERTY) as? String
            if result == nil {
                return ""
            }
            return result!
        }
        set{
//            objc_setAssociatedObject(self,
//                                     &PERSON_ID_NUMBER_PROPERTY,
//                                     newValue,
//                                     objc_AssociationPolicy(.OBJC_ASSOCIATION_ASSIGN))
            objc_setAssociatedObject(self, &PERSON_ID_NUMBER_PROPERTY, newValue, .OBJC_ASSOCIATION_ASSIGN)
           
        }
        
    }
}

@objcMembers
class MyPerson : NSObject, PersonProtocol {
    var height: Int? = 10
    
    func getName()  -> String   {
        let  info = "yinfan height = \(self.height!)"
        print(info)
        return info
    }
    
//    func getGender() -> String {
//        print("泰国")
//        return "泰国"
//    }
    
    
}
