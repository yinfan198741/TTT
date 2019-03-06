//
//  FunctionVC.swift
//  SwiftTest
//
//  Created by 尹凡 on 6/19/18.
//  Copyright © 2018 尹凡. All rights reserved.
//

import Foundation
import UIKit

class FunctionVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("FunctionVC")
        
        let left = BinarySearchTree.Node(BinarySearchTree.Leaf, 4, BinarySearchTree.Leaf)
        let right = BinarySearchTree.Node(BinarySearchTree.Leaf, 6, BinarySearchTree.Leaf)
        var node = BinarySearchTree.Node(left ,  5, right)
       
        print(node.isBST)
        print(node.contails(x: 3))
        print("before count = ", node)
        node.insert(x: 8)
        print("after count = ", node)
       
    }
}
