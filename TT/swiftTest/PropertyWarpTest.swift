//
//  PropertyWarpTest.swift
//  TT
//
//  Created by FYIN2 on 2023/5/14.
//  Copyright © 2023 fanyin. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefaultBack<T> {
    var defaultVaule: T
    var Key: String
    var projectedValue: UserDefaultBack<T> {
        return self
    }
    var wrappedValue: T {
        get {
            if let v =  UserDefaults().object(forKey: self.Key) as? T {
                return v
            }
            return defaultVaule
        }
        set {
            
            
            if newValue != nil {
                
            }
            
            //            if let np = newValue as? Optional<Any>,
            //                np != nil {
            //                UserDefaults().set(newValue, forKey: self.Key)
            //            } else {
            //                UserDefaults().removeObject(forKey: self.Key)
            //            }
            
            /// 转换成optonal 再取值
            if let  _v = newValue as? Any?,
               _v != nil {
                UserDefaults().set(newValue, forKey: self.Key)
            } else {
                UserDefaults().removeObject(forKey: self.Key)
            }
        }
    }
    init(wrappedValue defaultVaule: T, Key: String) {
        self.defaultVaule = defaultVaule
        self.Key = Key
    }
}

extension UserDefaultBack where T: ExpressibleByNilLiteral {
    init(Key: String) {
        self.defaultVaule = nil
        self.Key = Key
    }
}



@propertyWrapper
struct Capitalized {
    var wrappedValue: String? {
//        willSet {
//            newValue = newValue.uppercased()
//        }
        didSet {
            wrappedValue = wrappedValue?.uppercased()
        }
    }
    
    init(wrappedValue: String?) {
        self.wrappedValue = wrappedValue?.uppercased()
    }
}



//https://juejin.cn/post/7122667987902922789#heading-6

protocol DecodableDefaultSource {
    associatedtype Value: Decodable
    static var defaultValue: Value { get }
}

enum DecodableDefault {}

extension DecodableDefault {
    @propertyWrapper
    struct Wrapper<Source: DecodableDefaultSource> :Decodable {
        typealias Value = Source.Value
        var wrappedValue = Source.defaultValue
        init(wrappedValue: Value = Source.defaultValue) {
            self.wrappedValue = wrappedValue
        }
    }
}


extension KeyedDecodingContainer {
    func decode<T>(_ type: DecodableDefault.Wrapper<T>.Type, forKey key: Key)
    throws -> DecodableDefault.Wrapper<T> {
        try decodeIfPresent(type, forKey: key) ?? .init()
//        try decodeIfPresent(type, forKey: key) ?? (type.getDefaultVaule1!()) as! DecodableDefault.Wrapper<T>
    }
}

extension DecodableDefault {
    typealias Source = DecodableDefaultSource
    typealias List = Decodable & ExpressibleByArrayLiteral
    typealias Map = Decodable & ExpressibleByDictionaryLiteral
    
    enum Sources {
//        enum True: Source { static var defaultValue: Bool { true } }
//        enum False: Source { static var defaultValue: Bool { false } }
//        enum EmptyString: Source { static var defaultValue: String { "" } }
//        enum EmptyList<T: List>: Source { static var defaultValue: T { [] } }
//        enum EmptyMap<T: Map>: Source { static var defaultValue: T { [:] } }
        enum Zero: Source
        {
            static var defaultValue: Int { 0 }
        }
    }
}


enum Zero1: DecodableDefaultSource
{
    typealias Value = Int
    static var defaultValue: Int { 0 }
}


//extension DecodableDefault.Wrapper: Equatable where Value: Equatable {}
//extension DecodableDefault.Wrapper: Hashable where Value: Hashable {}

extension DecodableDefault.Wrapper: Encodable where Value: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}




//struct PropertyPerson: Codable {
//    @DecodableDefault.EmptyString var name: String
//    @DecodableDefault.EmptyList var skills: [String]
//    @DecodableDefault.EmptyList var teachers: [Teacher]
//    @DecodableDefault.Zero var money: Int
//}


struct PropertyPerson: Codable {
    @DecodableDefault.Wrapper<Zero1> var money: Int
    init(money: Int) {
        self.money = money
    }
    
    func __TS() {
//        let _TS =  DecodableDefault.Source { var defaultValue: Bool { true } }
//        print(_TS)
    }
}

//struct Teacher: Codable {
//    @DecodableDefault.EmptyString var name: String
//}


