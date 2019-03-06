//
//  GenericTest.swift
//  SwiftTest
//
//  Created by 尹凡 on 5/11/18.
//  Copyright © 2018 尹凡. All rights reserved.
//

import Foundation


enum GResult<T> {
    case Success(T)
    case Failure(NSError)
}





extension Collection where Element : Comparable {
    func largestValue() -> Self.Element? {
        // 'guard var' is, indeed, a real thing .__.
        guard var largestSoFar = first else {
            return nil
        }
       
        for item in self {
            // 'item' and 'largestSoFar' are both type Self.Generator.Element.
            // Because of the 'where' clause, we know that Self.Generator.Element is
            // Comparable, and so we can invoke the '>' operator on its instances.
            if item > largestSoFar {
                largestSoFar = item
            }
        }
        return largestSoFar
    }
}


func findLargestInArray<T: Comparable>(array: Array<T>) -> T? {
    if array.isEmpty { return nil }
    var soFar : T = array[0]
    for i in 1..<array.count {
        soFar = array[i] > soFar ? array[i] : soFar
    }
    return soFar
}


//enum SResult {
//
//}
//
//extension SResult {
//    // Transform the value of the 'Result' using one of two mapping functions
//    func transform<V>(left: T -> V, right: U -> V) -> V {
//        switch self {
//        case .Success(let value): return left(value)
//        case .Failure(let value): return right(value)
//        }
//    }
//}


class Box<T> {
    let value: T
    
    init(va: T) {
      self.value = va
    }
}

protocol Foo {
    
}

struct Bar<T>: Foo {
    let v:T
    init(va:T) {
        self.v = va
    }
}

struct Baz<T: Foo> {
    var array = [T]()
    
    init() {
        if T.self is Bar<String>.Type {
            // Error: Cannot invoke 'append' with an argument list of type (Bar)
            array.append(Bar<String>(va:"aaa") as! T)
        }
    }
}

struct protocalTest {
    var list:[Foo]?
    
    func logBar() {
        
        let array = [1,2,3,4,5]
        let v =   array.largestValue()
        print(v)
    }
}

