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

struct Capitalized : Codable {
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.wrappedValue = try container.decodeIfPresent(String.self, forKey: .wrappedValue)
    }
}



//extension String : myDefaultType {
//    static var getDefaultVar: Int {
//        return 123
//    }
//}
//
//
//
//
//struct myDefault_tt : myDefaultType {
//    typealias myDefaultValueType = Int
//
//    static var getDefaultVar: Int {
//        return 123
//    }
//}
//@Default<String> var name: String
//    @Default<Int> var age: Int


//@propertyWrapper
//struct myDefault_Int<T: Decodable>: Decodable  {
//    var wrappedValue: T
//    enum CodingKeys: CodingKey {
//        case wrappedValue
//    }
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.wrappedValue = try container.decode(T.self, forKey: .wrappedValue)
//    }
//
//}

struct myDefaults : Decodable {
    var wrappedValue: Int
}

protocol myDefaultType {
    associatedtype myDefaultValueType : Codable
    static var getDefaultVar: myDefaultValueType  { get }
}

@propertyWrapper
struct myDefault_d<T: myDefaultType>: Codable {
    var wrappedValue: T.myDefaultValueType
    
//    init(wrappedValue: T.myDefaultValueType) {
//        self.wrappedValue = wrappedValue
//    }
    enum CodingKeys: CodingKey {
        case wrappedValue
    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.wrappedValue = try container.decode(T.myDefaultValueType.self, forKey: .wrappedValue)
//    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        throw myError()
//    }
    
//    init(from decoder: Decoder) throws {
//        let container =  try decoder.container(keyedBy: CodingKeys.self)
//        self.wrappedValue = try container.decode(DecodableDefault.Wrapper<T>.self, forKey: .wrappedValue)
//    }
    
//    init(from decoder: Decoder) throws {
//        print("  init(from decoder: Decoder) throws {1")
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        print("  init(from decoder: Decoder) throws {2")
//        self.wrappedValue =  try container.decodeIfPresent(T.self, forKey: Self.CodingKeys.wrappedValue)!
//    }
}

extension KeyedDecodingContainer {
    
//    public func decode<T>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> T where T : Decodable
    func decode<T>(_ type: myDefault_d<T>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> myDefault_d<T> {
        let v = try decodeIfPresent(type, forKey: key)
        return v ??  myDefault_d(wrappedValue: T.getDefaultVar)
    }
}

extension Int : myDefaultType {
    static var getDefaultVar: Int {
        return 123
    }
}


struct Test123: Codable {
    @myDefault_d<Int> var age123: Int
//    enum CodingKeys: CodingKey {
//        case age123
//    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._age123 = try container.decode(myDefault_d<Int>.self, forKey: .age123)
    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
////        self._age123 = try container.decodeIfPresent(myDefault<Int>.self, forKey: .age123) ?? myDefault<Int>(wrappedValue: 100)
//    }
}

//extension KeyedDecodingContainer {
//    func decodeIfPresent<T>(_ type: T.Type, forKey key: K) throws -> T? where T: Decodable {
//        guard contains(key) else { return nil }
//        let decoder = try superDecoder(forKey: key)
//        let container = try decoder.singleValueContainer()
//        return try? container.decode(type)
//    }
//}

func WarpTest() {
    do {
        let defaultJson =
        """
            {"age123":null}
        """
            let myDefault = try JSONDecoder().decode(Test123.self, from: defaultJson.data(using: .utf8)!)
            print(myDefault)
    } catch  {
        print(error)
    }
}
 


//protocol DefaultValue {
//    associatedtype Value: Decodable
//    static var defaultValue: Value { get }
//}
//
//@propertyWrapper
//struct Default<T: DefaultValue>: Decodable {
//    var wrappedValue: T.Value
//
//    enum CodingKeys: CodingKey {
//        case wrappedValue
//    }
//
//
//    init(wrappedValue: T.Value) {
//        self.wrappedValue = wrappedValue
//    }
//
//    init(from decoder: Decoder) throws {
//        let container: KeyedDecodingContainer<Default<T>.CodingKeys> = try decoder.container(keyedBy: Default<T>.CodingKeys.self)
//        self.wrappedValue = try container.decode(T.Value.self, forKey: Default<T>.CodingKeys.wrappedValue)
//    }
//}
//
//
//
//extension KeyedDecodingContainer {
//    func decode<T>(_ type: Default<T>.Type, forKey key: Key) throws -> Default<T> where T: DefaultValue {
//        //判断 key 缺失的情况，提供默认值
//        (try decodeIfPresent(type, forKey: key)) ?? Default(wrappedValue: T.defaultValue)
//    }
//}
//
//
//extension Int: DefaultValue {
//    static var defaultValue = -1
//}
//
//extension String: DefaultValue {
//    static var defaultValue = "unknown123"
//}
//
//struct Person123: Decodable {
//    @Default<String> var name: String
////    @Default<Int> var age: Int
//    enum CodingKeys: CodingKey {
//        case name
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self._name = try container.decode(Default<String>.self, forKey: .name)
//    }
//}
//
//func WarpTest() {
//    do {
//        let data = #"{ "name": null, "age": null}"#
//        let p = try JSONDecoder().decode(Person123.self, from: data.data(using: .utf8)!)
//        print("Person = \(p) \n", "p.name = \(p.name)")
//
//    } catch {
//        print("error = \(error)")
//    }
//
//}

//Person(_name: Default<Swift.String>(wrappedValue: "unknown"), _age: Default<Swift.Int>(wrappedValue: -1))
//unknown  -1


//protocol myDefaultType: Decodable {
//    associatedtype myDefaultValueType
//    static var getDefaultVar: myDefaultValueType { get }
//}
//
//@propertyWrapper
//struct myDefault<T: myDefaultType>: Decodable {
//    var wrappedValue: T
//    enum CodingKeys: CodingKey {
//        case wrappedValue
//    }
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.wrappedValue = try container.decodeIfPresent(T.self, forKey: .wrappedValue) ?? T.getDefaultVar as! T
//    }
//}
//
//extension Int: myDefaultType {
//    static var getDefaultVar: Int {
//        return 123
//    }
//}
//
//struct Test123: Decodable {
//    @myDefault<Int> var age123: Int
//    enum CodingKeys: CodingKey {
//        case age123
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.age123 = try container.decode(myDefault<Int>.self, forKey: .age123)
//    }
//}
//
//func WarpTest() {
//    do {
//        let defaultJson = """
//            {"age123": null}
//        """
//        let myDefault = try JSONDecoder().decode(Test123.self, from: defaultJson.data(using: .utf8)!)
//        print(myDefault)
//    } catch {
//        print(error)
//    }
//}


//extension myDefault : myDefaultType  {
//    static var getDefaultVar:Int = 100
//}

//extension my

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
    func decode<T>(_ type: DecodableDefault.Wrapper<T>.Type, forKey key: Key) throws -> DecodableDefault.Wrapper<T> {
        try decodeIfPresent(type, forKey: key) ?? .init()
        //        try decodeIfPresent(type, forKey: key) ?? (type.getDefaultVaule1!()) as! DecodableDefault.Wrapper<T>
    }
    
    
    func decode<T>(_ type: T.Type, forKey key: Key) throws -> Capitalized {
        .init(wrappedValue: nil)
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


