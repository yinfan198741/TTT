//
//  curry.swift
//  SwiftTest
//
//  Created by 尹凡 on 3/7/18.
//  Copyright © 2018 尹凡. All rights reserved.
//

import Foundation



func testCurry(){
    let greaterThan10 = greaterThan(comparer: 10);
    let res = greaterThan10(11)
    print("res = \(res)")
}

func greaterThan(comparer: Int) -> ((Int) -> Bool) {
//    return { $0 > comparer }
    func gt(num: Int) -> Bool {
        if comparer > comparer {
             return true
        }
        else {
             return false
        }
       
    }
    return gt
}

protocol TargetAction {
    func performAction()
}

struct TargetActionWrapper<T: AnyObject>:
TargetAction {
    weak var target: T?
    let action: (T) -> () -> ()
    
    func performAction() -> () {
        if let t = target {
            action(t)()
        }
    }
}

enum ControlEvent {
    case TouchUpInside
    case ValueChanged
    // ...
}


class Control {
    var actions = [ControlEvent: TargetAction]()
    
    func setTarget<T: AnyObject>(target: T,
                                 action: @escaping (T) -> () -> (),
                                 controlEvent: ControlEvent) {
        
        actions[controlEvent] = TargetActionWrapper(
            target: target, action: action)
    }
    
    func removeTargetForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent] = nil
    }
    
    func performActionForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent]?.performAction()
    }
}



