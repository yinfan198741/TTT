//
//  Sequence.swift
//  SwiftTest
//
//  Created by 尹凡 on 5/11/18.
//  Copyright © 2018 尹凡. All rights reserved.
//

import Foundation


//class item: Sequence {
//    var value: String
//    var next:item?
//    init(va: String) {
//        self.value = va
//    }
//
//    func next() -> item? {
//                return self.next
//            }
//
//}


//class item: Sequence {
//    func enumerated() -> EnumeratedSequence<item> {
//        return
//    }
//}


protocol itemProtocol {
    func next() -> Self
}


struct itemGenerator<T: itemProtocol> : IteratorProtocol {
    
    var itemHead:T?
    
    init(Head:T) {
        self.itemHead = Head
    }
    
    public mutating func next() -> T? {
        return itemHead?.next()
    }
}

//class item<T> : Sequence, IteratorProtocol{
final class item<T> : Sequence ,itemProtocol {
    
    typealias Iterator = itemGenerator<item<T>>
    var value:T?
    var _next:item<T>?
    init(va:T) {
        self.value = va
       
    }
    
    func next() -> item<T> {
        return self
    }
    
    func makeIterator() -> Iterator {
        return itemGenerator(Head:self)
    }
}

//struct itemGenerator: Generator{
//
//}

//extension item : Sequence {
//    func generate() -> itemGenerator {
//        return itemGenerator()
//    }
//}





//func searchForModel(matching query: String) -> Model? {
//    for model in ModelSequence() {
//        if model.title.contains(query) {
//            return model
//        }
//    }
//
//    return nil
//}
//
//



struct Model {
    init(at: Int) {
        
    }
}

class MyModel {
    
}


struct ModelIterator: IteratorProtocol {
    
    typealias Element = Model
    
    private let database: String
    private var index = 0
    
    
    init(database:String) {
        self.database = database
    }
    
    mutating func next() -> Element? {
        let model = Model(at: index)
        index += 1
        return model
    }
}

class  ModelSequence: Sequence {
    
    typealias Iterator = ModelIterator
    
    typealias Element = Iterator.Element
    
    func makeIterator() -> Iterator {
        return ModelIterator(database:"aa")
    }
}
//extension SequenceOf {
//    func skip (n:Int) -> SequenceOf<T> {
//        var generator =  self.generate();
//        for _ in 0..n {
//            println("skipped")
//            generator.next()
//        }
//        return SequenceOf(generator)
//    }
//}


class ModelLoader {
    func loadAllModels() -> AnySequence<Model> {
        return AnySequence<Model> { () -> AnyIterator<Model> in
            var index = 0
            return AnyIterator {
                let model = Model(at: index)
                index += 1
                return model
            }
        }
    }
}

extension Sequence where Element: MyPerson {
    
}





//struct ModelSequence: IteratorProtocol, Sequence {
//
//
//    public mutating func next() -> Elements.Element?{
//        return nil
//    }
//}

//struct SS : Sequence {
//
//}
//
//struct GG : Sequence.Generator {
//
//}


//struct InterposeGenerator<G: Generator, T where T == G.Element>
//: Generator {
//    let sep: T
//    var gen: G
//    var needSep: Bool
//    var nextOrNil: T?
//
//    init (sep: T, gen: G) {
//        self.sep = sep
//        self.needSep = false
//        self.gen = gen
//        self.nextOrNil = self.gen.next()
//    }
//
//    mutating func next() -> T? {
//        if needSep {
//            needSep = false
//            return sep
//        } else {
//            let n = nextOrNil
//            if n {
//                nextOrNil = gen.next()
//                needSep = nextOrNil != nil
//            }
//            return n
//        }
//    }
//}



struct TestSeq {
    func test() {
        
//        let evenNumbers = filter(MyPerson()) { $0 % 2 == 0}
        
        let a = item(va:"aa")
        let b = item(va:"bb")
        let c = item(va:"cc")
        a._next = b
        b._next = c
        
        for item in a {
            print(item.value)
        }
        
    }
}
