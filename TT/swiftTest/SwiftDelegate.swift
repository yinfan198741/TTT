//
//  SwiftDelegate.swift
//  TT
//
//  Created by 尹凡 on 9/17/18.
//  Copyright © 2018 fanyin. All rights reserved.
//

import Foundation

protocol FileImporter : AnyObject {
    func fileImporter(_ importer: FileImporter, shouldImportFile file: String) -> Bool
    func fileImporter(_ importer: FileImporter, didAbortWithError file: String) -> Bool
    func fileImporterDidFinish(_ importer: FileImporter)
}

class FileImporterImpl {
    weak var delegate : FileImporter?
}


struct FileImporterConfiguration {
    var predicate: ((String) -> Bool)?
    var errorHandler: ((Error) -> Void)?
    var completionHandler: (() -> Void)?
}

extension FileImporterConfiguration {
    static var ALLFile : FileImporterConfiguration {
//        return FileImporterConfiguration()
        return .init()
    }
}

