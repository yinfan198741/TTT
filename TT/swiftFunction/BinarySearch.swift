//
//  BinarySearch.swift
//  SwiftTest
//
//  Created by 尹凡 on 6/19/18.
//  Copyright © 2018 尹凡. All rights reserved.
//

import Foundation

indirect enum BinarySearchTree {
    case Leaf
    case Node(BinarySearchTree,Int,BinarySearchTree)
}


extension BinarySearchTree {
    init() {
        self = .Leaf
    }
    
    init(_ value: Int) {
        self = .Node(.Leaf, value, .Leaf)
    }
}


extension BinarySearchTree {
    var count:Int {
        switch self {
        case .Leaf:
            return 1
        case let .Node(left, _, right):
            return 1 + left.count + right.count
        }
    }
}

extension BinarySearchTree {
    var elements: [Int] {
        switch self {
        case .Leaf:
            return []
        case let .Node(left, x, right):
            return left.elements + [x] + right.elements
        }
    }
}

extension BinarySearchTree {
    var isBST: Bool {
        switch self {
        case .Leaf:
            return true
         case let .Node(left, x, right):
            return left.elements.all{ y in y < x}
                && right.elements.all{y in y > x}
                && left.isBST
                && right.isBST
      
        }
    }
}

extension BinarySearchTree {
    func contails(x: Int) -> Bool {
        switch self {
        case .Leaf:
            return false
            
        case let .Node(_, _x, _) where _x == x :
            return true
            
        case let .Node(_, _x, right) where _x < x :
            return right.contails(x:x)
            
        case let .Node(left, _x, _) where _x > x :
            return left.contails(x:x)
            
        default:
            return false
       }
    }
    
    mutating func insert(x: Int) {
        switch self {
        case .Leaf:
            self = .Node(.Leaf, x , .Leaf)
        case .Node(var left, let y, var right):
            if x < y
            {
                left.insert(x:  x)
            }
            if x > y
            {
                right.insert(x: x)
            }
//            self =  .Node(.Leaf, x , .Leaf)
            
//        case let .Node(_, _x, _) where _x == x :
//            print("has one")
//        case  .Node(_, let _x,var  right) where _x < x :
//            return right.insert(x:)
//
//        case  .Node(var left, let _x, _) where _x > x :
//            return left.insert(x:x)
       
        }
    }
}


extension Sequence {
    func all(predict: (Element) -> Bool) -> Bool {
        for x in self where !predict(x) {
            return false
        }
        return true
    }
}



