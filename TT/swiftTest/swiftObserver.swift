//
//  swiftObserver.swift
//  TT
//
//  Created by 尹凡 on 9/13/18.
//  Copyright © 2018 fanyin. All rights reserved.
//

import Foundation
import UIKit


class CancleToken {
    
    var calcleTask:(()->Void)?
    
    init?(task: (()->Void)?) {
        self.calcleTask = task
    }
    
    func cancelTaks() {
        calcleTask.map{
            $0()
        }
    }
}


class AudioPlayer {
    var observations = (
//        started: Array<(AudioPlayer, Item) -> Void>(),
        started: [(AudioPlayer, Item) -> Void](),
        paused: [UUID: (AudioPlayer, Item) -> Void](),
        stopped: [(AudioPlayer) -> Void]()
    )
}

extension AudioPlayer {
    func observerStart(_ player:AudioPlayer, callBack: @escaping (AudioPlayer, Item) -> Void) {
//        let weakCallabck = { [weak player] in callBack(player!,nil) }
//        player.observations.started.append(weakCallabck)
        
        player.observations.started.append(callBack)
    }
    
    func notifyStarted() {
        self.observations.started.forEach { item in
            item(self,Item(identifier: "Started", value: "a.mp4"))
        }
    }
    func observerPause(_ player:AudioPlayer, callBack: @escaping (AudioPlayer, Item) -> Void)
     -> CancleToken? {
        let uuid = UUID()
        player.observations.paused[uuid] = callBack
        return CancleToken(task: { [weak player] in
            player?.observations.paused[uuid] = nil
        })
    }
    
    func notifyPause() {
        self.observations.paused.forEach { item in
//            item(self,Item(identifier: "Pause", value: "a.mp4"))
            item.value(self,Item(identifier: "Pause", value: "a.mp4"))
        }
    }
}



public class ocCall: NSObject {
    static func ObejctCall(_ vc: UIViewController) {
        print("ObejctCall")
        let svc = swiftVC.init()
        vc.present(svc, animated: false)
        
        let player = AudioPlayer()
        
        player.observerStart(player) { (_ , _) in
            let log = svc.aaaa()
            print(log)
        }
    
    }
}


class Event {
//    private var observers:[() -> Void] = []
    private var observers = [() -> Void]()
    private var observerss = [Int]()
//    private var observerss1:[Int] = ()
    func trigger() {
        for observer in observers {
            observer()
        }
    }
    
    func addObserver<T: AnyObject>(_ ob: T, using closure: @escaping (T) -> Void) {
        print("aaaaa")
        observers.append { [weak ob] in
//            if let obj = ob {
//                closure(obj)
//            }
            ob.map(closure)
        }
    }
}

class ListViewModel {
    let numberOfItemsChanged = Event()
    var items: [Int] = [] {
        didSet {
            itemsDidChange(from: oldValue)
        }
    }
    private func itemsDidChange(from previousItems: [Int]) {
        if previousItems.count != items.count {
            numberOfItemsChanged.trigger()
        }
    }
}

class ObserverTest {
    
    func Test() {
        let lvm = ListViewModel()
        lvm.items = [1,2,3]
        lvm.numberOfItemsChanged.addObserver(lvm) { _ in
            print("lvm change")
        }
        lvm.items = [4,5]
    }
}


