//
//  mutating.swift
//  TT
//
//  Created by 尹凡 on 3/6/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

import Foundation
struct Point {
  var x = 0, y = 0
  
 mutating func moveXBy(x:Int,yBy y:Int) {
    self.x += x
    // Cannot invoke '+=' with an argument list of type '(Int, Int)'
    self.y += y
    // Cannot invoke '+=' with an argument list of type '(Int, Int)'
  }
}
