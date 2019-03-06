//
//  swiftCaller.swift
//  TT
//
//  Created by 尹凡 on 3/6/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

import Foundation

struct swiftCallOc {
  func callgetreturnNil()  {
    let name = OCCallTester.getNameNil()
    print(name)
    print(name?.count)
   
    let ocObejct = OCCallTester()
    let nameProperty = ocObejct.nameProperty
    print(nameProperty)
    print(nameProperty?.count)
  }
}
