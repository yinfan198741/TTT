//
//  GenericBox.swift
//  SwiftTest
//
//  Created by 尹凡 on 5/13/18.
//  Copyright © 2018 尹凡. All rights reserved.
//

import Foundation


protocol itemElement {
    init?()
}

protocol ValueProviderType {
    associatedtype Value
    func valueAtTime(time: String) -> Value?
}


//struct Car {
//    var color: ValueProviderType
//    var postion: ValueProviderType
//}


struct AnyValueProvider<T> {
    
    private var _fvat :(String) -> T?;
    
    init<V : ValueProviderType>(_ vpt : V) where V.Value == T {
        self._fvat = vpt.valueAtTime
    }
    
    func valueAtTime(time: String) -> T? {
        return self._fvat(time)
    }
    
}


struct ConstantValue<T>: ValueProviderType{
    typealias Value = T
    func valueAtTime(time: String) -> T? {
//        return T()
        return nil
    }
    
    var VV:T
    init(_ va:T) {
        self.VV = va
    }
    
}

struct TimeTypeView<T: itemElement> :ValueProviderType {
    typealias Value = T
    func valueAtTime(time: String) -> T? {
        return T()
    }
}


struct Car {
    var color:AnyValueProvider<String>?
    var postion: AnyValueProvider<Double>?
}


struct TestCar {
    func TTT() {
        
        var carA = Car()
        carA.postion = AnyValueProvider(ConstantValue<Double>(123))
        

       
        //        carA.color = AnyValueProvider(ConstantValue<String>("red"))
        //
        //        var car = Car()
        //        car.color = AnyValueProviderType<ConstValueType<String>>
    }
}





//struct Time {
//}
//
//
//protocol ValueProviderType {
//    associatedtype Value
//    func valueAtTime(time: Time) -> Value
//}
//
//struct AnyValueProvider<T>: ValueProviderType {
//    let _valueAtTime: (Time) -> T
//    init<V: ValueProviderType>(_ delegatee: V) where V.Value == T {
//        _valueAtTime = delegatee.valueAtTime
//    }
//    func valueAtTime(time: Time) -> T {
//        return _valueAtTime(time)
//    }
//}
//
//
//struct ConstantValue<T>: ValueProviderType {
//    var value: T
//    init(_ value: T) {
//        self.value = value
//    }
//    func valueAtTime(time: Time) -> T {
//        return value
//    }
//}
//struct TimeDependentValue<T>: ValueProviderType {
//    var min: T
//    var max: T
//    init(_ min: T, _ max: T) {
//        self.min = min
//        self.max = max
//    }
//    func valueAtTime(time: Time) -> T {
//        return min  // just for the example
//    }
//}
//
//
//
//struct Car {
//    var color: AnyValueProvider<String>? = nil
//    var position: AnyValueProvider<Double>? = nil
//    init () {}
//
//}







protocol ValueProvider
{
//    associatedtype ValueType
    func valueInContext(context: String) -> String
}





protocol MythicalType {
    associatedtype FoodType
    var lastEatenFood: FoodType { get set }
}



class AnyMythicalType<T>: MythicalType {
    
    var lastEatenFood: T
    typealias FoodType = T
    required init<U: MythicalType>(_ mythicalCreature: U) where U.FoodType == T {
        lastEatenFood = mythicalCreature.lastEatenFood
    }
}

//struct AnyValueProvider<T>: ValueProviderType {
//    let _valueAtTime: (Time) -> T
//    init<V: ValueProviderType where V.Value == T>(_ delegatee: V) {
//        _valueAtTime = delegatee.valueAtTime
//    }
//    func valueAtTime(time: Time) -> T {
//        return _valueAtTime(time)
//    }
//}


struct Constant<T>: ValueProvider
{
    func valueInContext(context: String) -> String {
        return "aaa"
    }
    
    typealias ValueType = String
    
    var value: T
    init(value: T)
    {
        self.value = value
    }
    func value(context: String) -> T
    {
        return value
    }
}

struct Thing
{
    var position: ValueProvider
    var name: ValueProvider
   
}

