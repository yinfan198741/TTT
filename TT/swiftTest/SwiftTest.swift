//
//  SwiftTest.swift
//  TT
//
//  Created by fanyin on 2018/8/6.
//  Copyright © 2018 fanyin. All rights reserved.
//

import Foundation
import UIKit

func changeC() {
    typealias privateMethodAlias = @convention(c) (Any) -> UIImage? // 1
//    let originalImageFunction = unsafeBitCast(sym, to: privateMethodAlias.self) // 2
//    let originalImage = originalImageFunction(imageGenerator) // 3
//    self.imageView.image = originalImage // 4
}
