//
//  CombineTestViewController.swift
//  TT
//
//  Created by Fan Yin on 2021/12/6.
//  Copyright © 2021 fanyin. All rights reserved.
//

import UIKit
import Combine



//public class C1: NSObject {
//    public func method() { print("C") }
//}
//
//public class B1: C1 {
//}
//extension B1 {
//    override public func method() { print("B") }
//}
//
//public class A1: B1 {
//}
//extension A1 {
//    override public func method() { print("A") }
//}

public class AA: NSObject {
     func method() { print("C") }
    
     public var method1:(Int) -> String {
         return doMethod1
     }
}

extension AA {
    func doMethod1(i : Int) -> String{
        return "AA"
    }
}


public class BB: AA {
    override  func method() { print("BB") }
}


public class CC: AA {
    override  func method() { print("CC") }
}


class BottomAlertBaseView: UIView {

    lazy var titleLabel: UILabel =   {
        let t = UILabel.init()
        return t
    }()
  
     override init(frame: CGRect) {
        super.init(frame:frame)
         self.setupView()
    }
    
    func setupView()
    {
        self.titleLabel = UILabel.init()
    }
    
    
//    convenience init() {
//        self.titleLabel = UILabel.init()
////        self.init(frame:CGRect.init(x: 0,y: 0,width: 0,height: 0))
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension UIControl {
    
    class InteractionSubscription<S: Subscriber>: Subscription where S.Input == Event {
        
        
        var control: UIControl
        var event: Event
        var subscriber: S
        
        init(control: UIControl, event: Event, s: S) {
            self.control = control
            self.event = event
            self.subscriber = s
            
            control.addTarget(self, action: #selector(eventTriger), for: event)
        }
        
        @objc
        func eventTriger ()
        {
            NSLog("eventTriger")
            send()
        }
        
        func request(_ demand: Subscribers.Demand) {
           
        }
        
        func cancel() {
            
        }
        
        func send() {
            self.subscriber.receive(event)
        }
        
    }
    
    struct InteractionPublisher: Publisher {
        
        typealias Output = Event
        typealias Failure = Never
        var control: UIControl
        var event: Event
        
        
        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Event == S.Input {
            let subtion = InteractionSubscription<S>(control: control, event: event, s: subscriber)
            subscriber.receive(subscription: subtion)
        }
    }
        
    
    
    func publisher(for event: UIControl.Event) -> UIControl.InteractionPublisher {
        return InteractionPublisher(control: self, event: event)
    }
    
}


class CombineTestViewController: UIViewController {

    
    
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.combineTest()
        self.loadTest()
    }
    

    func loadTest()  {
        let b = UIButton(frame: CGRect.init(x: 120, y: 100, width: 100, height: 100))
        b.setTitle("loadTest", for: .normal)
        b.addTarget(self, action: #selector(tt), for: .touchUpInside)
        b.backgroundColor = .blue
        self.view.addSubview(b)
//        b.publisher(for: .touchUpInside).sink { [weak self] s in
//            print("s touchUpInside = \(s)")
//            self?.loadTestImp()
//        }.store(in: &cancellables)
        
    }
    
    @objc
    func loadTestImp() {
        NSLog("loadTestImp")
        
        let tool = LoadTool<LoadUser, LoadUser>(localUser: loadFileTool(),
                                                netUser: loadNetTool())
        
        
        tool.test()
        
//        tool.fetchUser().sink { comp in
//            print("comp = \(comp)")
//        } receiveValue: { usr in
//            print("usr = \(usr)")
//        }

    }
    
    func combineTest() {
        let b = UIButton(frame: CGRect.init(x: 10, y: 100, width: 100, height: 100))
        b.setTitle("TT", for: .normal)
        b.addTarget(self, action: #selector(tt), for: .touchUpInside)
        b.backgroundColor = .yellow
        self.view.addSubview(b)
        
        
        b.publisher(for:\.isSelected).sink { s in
            NSLog("s = \(s)")
        }.store(in: &cancellables)
        
        b.isSelected = true
        
        
//        b.publisher(for: .touchUpInside)
//                    .sink { _ in
//                        print("Tapped")
//                    } .store(in: &cancellables)
        
        
        b.publisher(for: .touchUpInside).sink { s in
            print("s touchUpInside = \(s)")
        }.store(in: &cancellables)
        
//        b.publisher(for: .touchUpInside).sink { s in
//            NSLog("s = \(s)")
//        }.store(in: &cancellables)
    }
    
    
    @objc
    func tt()
    {
        
        
        
        let c = CC()
        c.method()
        
//        NSLog("12")
//
//        let f1 = Future<String, Error> { p in
//            p(.success("res1"))
//        }
//
//        let f2 = Future<String, Error> { p in
//            p(.success("res2"))
//        }
        
        
        
//        let p0 = f1.combineLatest(f2)
//            .first()
//            .map({ out in
//                return out.1
//            })
//        p0.sink { _ in
//
//        } receiveValue: { s in
//            NSLog("s = \(s)")
//        }
//
//
//        let p = f1.combineLatest(f2)
//            .first()
//            .map({ out in
//                return out.1
//            })
//            .eraseToAnyPublisher()
//        p.sink { _ in
//
//        } receiveValue: { v in
//            NSLog("v = \(v)")
//        }
        
        
 

//        // In another module:
//        let nonErased = TypeWithSubject()
//        if let subject = nonErased.publisher as? PassthroughSubject<Int,Never> {
//            print("Successfully cast nonErased.publisher.")
//        }
//        let erased = TypeWithErasedSubject()
//        if let subject = erased.publisher as? PassthroughSubject<Int,Never> {
//            print("Successfully cast erased.publisher.")
//        }

        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
