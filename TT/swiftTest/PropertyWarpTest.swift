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

extension Int : myDefaultType { static var getDefaultVar: Int { return 1000 } }
extension String : myDefaultType { static var getDefaultVar: String { return "default String" } }



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

func WarpTest1() {
    do {
//        let defaultJson =
//        """
//            {"age123":null}
//        """
//            let myDefault = try JSONDecoder().decode(Test123.self, from: defaultJson.data(using: .utf8)!)
        
        
//        let defaultJson =
//        """
//        { "age123": 36 }
//        """
        
        let defaultJson =
        """
        {"age123":36}
        """
        
        let myDefault = try JSONDecoder().decode(Test123.self, from: defaultJson.data(using: .utf8)!)
        print(myDefault)
    }  catch DecodingError.dataCorrupted(let context) {
        print(context)
    } catch DecodingError.keyNotFound(let key, let context) {
        print("Key '\(key)' not found:", context.debugDescription)
        print("codingPath:", context.codingPath)
    } catch DecodingError.valueNotFound(let value, let context) {
        print("Value '\(value)' not found:", context.debugDescription)
        print("codingPath:", context.codingPath)
    } catch DecodingError.typeMismatch(let type, let context) {
        print("Type '\(type)' mismatch:", context.debugDescription)
        print("codingPath:", context.codingPath)
    } catch {
        print("error: ", error)
    }
}
 


protocol DefaultValue {
    associatedtype Value: Decodable
    static var defaultValue: Value { get }
}

@propertyWrapper
struct Default<S: DefaultValue>: Decodable {
    var wrappedValue: S.Value


//    init(from decoder: Decoder) throws {
//        let container: KeyedDecodingContainer<Default<T>.CodingKeys> = try decoder.container(keyedBy: Default<T>.CodingKeys.self)
//        self.wrappedValue = try container.decode(T.Value.self, forKey: Default<T>.CodingKeys.wrappedValue)
//    }
}



extension KeyedDecodingContainer {
    
    func decode(_ type: Default<String>.Type, forKey key: Key) throws -> Default<String> {
        //判断 key 缺失的情况，提供默认值
//        (try decodeIfPresent(type, forKey: key)) ?? Default(wrappedValue: T.defaultValue)
        
//        decodeIfPresent(<#T##type: Bool.Type##Bool.Type#>, forKey: <#T##CodingKey#>)
        
////        print("key = \(key)")
//        let decoder = try superDecoder(forKey: key)
//        let container = try decoder.singleValueContainer()
//        let v = container.decode(type)
//        return try container.decode(type) ?? Default(wrappedValue: T.defaultValue)
        

        let v = try decodeIfPresent(AnyDecodable.self, forKey: key)?.value
        print("v = \(v)")
        if let vT = v as? String {
            Default<String>(wrappedValue: vT)
        }
        
        return  Default(wrappedValue: "123")
//        if let value = try decodeIfPresent(type, forKey: key) {
//            return value
//        } else {
//            return Default(wrappedValue: P.defaultValue)
//        }
        
//            do {
//                let value = try decode(Bool.self, forKey: key)
//                return Default(wrappedValue: value)
//            } catch let error {
//                guard let decodingError = error as? DecodingError,
//                    case .typeMismatch = decodingError else {
//                        return Default(wrappedValue: T.defaultValue)
//                }
//                if let intValue = try? decodeIfPresent(Int.self, forKey: key),
//                    let bool = Bool(exactly: NSNumber(value: intValue)) {
//                    return Default(wrappedValue: bool)
//                } else if let stringValue = try? decodeIfPresent(String.self, forKey: key),
//                    let bool = Bool(stringValue) {
//                    return Default(wrappedValue: bool)
//                } else {
//                    return Default(wrappedValue: T.defaultValue)
//                }
//            }
        
    }
    
    func decode<P>(_ type_: Default<P>.Type, forKey key: Key) throws -> Default<P> {
        //判断 key 缺失的情况，提供默认值
//        (try decodeIfPresent(type, forKey: key)) ?? Default(wrappedValue: T.defaultValue)
        
//        decodeIfPresent(<#T##type: Bool.Type##Bool.Type#>, forKey: <#T##CodingKey#>)
        
////        print("key = \(key)")
//        let decoder = try superDecoder(forKey: key)
//        let container = try decoder.singleValueContainer()
//        let v = container.decode(type)
//        return try container.decode(type) ?? Default(wrappedValue: T.defaultValue)
        
        
        let v = try decodeIfPresent(AnyDecodable.self, forKey: key)?.value
        print("v = \(v)")
        
        
        
//        if let vT = v as? P , P.Value == type(of: vT){
//            Default<P>(wrappedValue: vT)
//        }
        
        if let value = try decodeIfPresent(type_, forKey: key) {
            return value
        } else {
            return Default(wrappedValue: P.defaultValue)
        }
        
//            do {
//                let value = try decode(Bool.self, forKey: key)
//                return Default(wrappedValue: value)
//            } catch let error {
//                guard let decodingError = error as? DecodingError,
//                    case .typeMismatch = decodingError else {
//                        return Default(wrappedValue: T.defaultValue)
//                }
//                if let intValue = try? decodeIfPresent(Int.self, forKey: key),
//                    let bool = Bool(exactly: NSNumber(value: intValue)) {
//                    return Default(wrappedValue: bool)
//                } else if let stringValue = try? decodeIfPresent(String.self, forKey: key),
//                    let bool = Bool(stringValue) {
//                    return Default(wrappedValue: bool)
//                } else {
//                    return Default(wrappedValue: T.defaultValue)
//                }
//            }
        
    }
}


extension Int: DefaultValue {
    static var defaultValue = -1
}

extension String: DefaultValue {
    static var defaultValue = "unknown123"
}

struct Person123: Decodable {
    @Default<String> var name: String
    enum CodingKeys: CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._name = try container.decode(Default<String>.self, forKey: .name)
    }
}

func WarpTest() {
    do {
        let jsonData = #"{"name":"QmV0dGVyQ29kYWJsZQ=="}"#.data(using: .utf8)!
        let p = try JSONDecoder().decode(Person123.self, from: jsonData)
        print("Person = \(p) \n")

    } catch {
        print("error = \(error)")
    }

}

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


//extension KeyedDecodingContainer {
//    func decode<T>(_ type: DecodableDefault.Wrapper<T>.Type, forKey key: Key) throws -> DecodableDefault.Wrapper<T> {
//        try decodeIfPresent(type, forKey: key) ?? .init()
//        //        try decodeIfPresent(type, forKey: key) ?? (type.getDefaultVaule1!()) as! DecodableDefault.Wrapper<T>
//    }
//
//
//    func decode<T>(_ type: T.Type, forKey key: Key) throws -> Capitalized {
//        .init(wrappedValue: nil)
//    }
//
//}

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





struct AnyDecodable: Decodable {
    public let value: Any

    public init<T>(_ value: T?) {
        self.value = value ?? ()
    }
}

@usableFromInline
protocol _AnyDecodable {
    var value: Any { get }
    init<T>(_ value: T?)
}

extension AnyDecodable: _AnyDecodable {}

extension _AnyDecodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            #if canImport(Foundation)
                self.init(NSNull())
            #else
                self.init(Self?.none)
            #endif
        } else if let bool = try? container.decode(Bool.self) {
            self.init(bool)
        } else if let int = try? container.decode(Int.self) {
            self.init(int)
        } else if let uint = try? container.decode(UInt.self) {
            self.init(uint)
        } else if let double = try? container.decode(Double.self) {
            self.init(double)
        } else if let string = try? container.decode(String.self) {
            self.init(string)
        } else if let array = try? container.decode([AnyDecodable].self) {
            self.init(array.map { $0.value })
        } else if let dictionary = try? container.decode([String: AnyDecodable].self) {
            self.init(dictionary.mapValues { $0.value })
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "AnyDecodable value cannot be decoded")
        }
    }
}

extension AnyDecodable: Equatable {
    public static func == (lhs: AnyDecodable, rhs: AnyDecodable) -> Bool {
        switch (lhs.value, rhs.value) {
        #if canImport(Foundation)
            case is (NSNull, NSNull), is (Void, Void):
                return true
        #endif
        case let (lhs as Bool, rhs as Bool):
            return lhs == rhs
        case let (lhs as Int, rhs as Int):
            return lhs == rhs
        case let (lhs as Int8, rhs as Int8):
            return lhs == rhs
        case let (lhs as Int16, rhs as Int16):
            return lhs == rhs
        case let (lhs as Int32, rhs as Int32):
            return lhs == rhs
        case let (lhs as Int64, rhs as Int64):
            return lhs == rhs
        case let (lhs as UInt, rhs as UInt):
            return lhs == rhs
        case let (lhs as UInt8, rhs as UInt8):
            return lhs == rhs
        case let (lhs as UInt16, rhs as UInt16):
            return lhs == rhs
        case let (lhs as UInt32, rhs as UInt32):
            return lhs == rhs
        case let (lhs as UInt64, rhs as UInt64):
            return lhs == rhs
        case let (lhs as Float, rhs as Float):
            return lhs == rhs
        case let (lhs as Double, rhs as Double):
            return lhs == rhs
        case let (lhs as String, rhs as String):
            return lhs == rhs
        case let (lhs as [String: AnyDecodable], rhs as [String: AnyDecodable]):
            return lhs == rhs
        case let (lhs as [AnyDecodable], rhs as [AnyDecodable]):
            return lhs == rhs
        default:
            return false
        }
    }
}

extension AnyDecodable: CustomStringConvertible {
    public var description: String {
        switch value {
        case is Void:
            return String(describing: nil as Any?)
        case let value as CustomStringConvertible:
            return value.description
        default:
            return String(describing: value)
        }
    }
}

extension AnyDecodable: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch value {
        case let value as CustomDebugStringConvertible:
            return "AnyDecodable(\(value.debugDescription))"
        default:
            return "AnyDecodable(\(description))"
        }
    }
}

extension AnyDecodable: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch value {
        case let value as Bool:
            hasher.combine(value)
        case let value as Int:
            hasher.combine(value)
        case let value as Int8:
            hasher.combine(value)
        case let value as Int16:
            hasher.combine(value)
        case let value as Int32:
            hasher.combine(value)
        case let value as Int64:
            hasher.combine(value)
        case let value as UInt:
            hasher.combine(value)
        case let value as UInt8:
            hasher.combine(value)
        case let value as UInt16:
            hasher.combine(value)
        case let value as UInt32:
            hasher.combine(value)
        case let value as UInt64:
            hasher.combine(value)
        case let value as Float:
            hasher.combine(value)
        case let value as Double:
            hasher.combine(value)
        case let value as String:
            hasher.combine(value)
        case let value as [String: AnyDecodable]:
            hasher.combine(value)
        case let value as [AnyDecodable]:
            hasher.combine(value)
        default:
            break
        }
    }
}

