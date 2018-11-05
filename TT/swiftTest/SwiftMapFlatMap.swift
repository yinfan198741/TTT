//
//  SwiftMapFlatMap.swift
//  TT
//
//  Created by 尹凡 on 9/17/18.
//  Copyright © 2018 fanyin. All rights reserved.
//

import Foundation

enum State: String {
    case Default = ""
    case Cancelled = "CANCELLED"
    
    static func parseState(state: String?) -> State {
        guard let state = state else {
            return .Default
        }
        return State(rawValue: state) ?? .Default
    }
    
    static func mapParseState(state: String?) -> State {
        let a = state.flatMap{return State.init(rawValue: $0)} ?? .Default
//         let b = state.map{return State.init(rawValue: $0)}
        return a
    }
}

struct Item {
    let identifier: String
    let value: String
}

class Items {
    let items: [Item] = []
    func find(identifier: String) -> Item? {
       let index = items.index { item -> Bool in
            if item.identifier == identifier {
                return true
            }
         return false
        }
        return index.map { items[$0] }
    }
}

struct Person {
    let firstName: String
    let lastName: String
    
    init?(json:[String:AnyObject]?) {
        if let first = json?["firstName"] as? String,
            let last = json?["lastName"] as? String {
            self.firstName = first
            self.lastName = last
        }
        return nil
    }
    
    func createPerson(json:[String:AnyObject]?) -> Person? {
        return json.flatMap { Person(json: $0) }
    }
}



