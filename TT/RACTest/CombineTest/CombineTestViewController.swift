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


public struct Always<Output>: Publisher {
  public typealias Failure = Never

  public let output: Output

  public init(_ output: Output) {
    self.output = output
  }

  public func receive<S: Subscriber>(subscriber: S) where S.Input == Output, S.Failure == Failure {
    let subscription = Subscription(output: output, subscriber: subscriber)
    subscriber.receive(subscription: subscription)
  }
}

private extension Always {
  final class Subscription<S: Subscriber> where S.Input == Output, S.Failure == Failure {
    private let output: Output
    private var subscriber: S?

    init(output: Output, subscriber: S) {
      self.output = output
      self.subscriber = subscriber
    }
  }
}

extension Always.Subscription: Cancellable {
  func cancel() {
    subscriber = nil
  }
}

extension Always.Subscription: Subscription {
    func request(_ demand: Subscribers.Demand) {
        //    var demand = demand
        //    while let subscriber = subscriber, demand > 0 {
        //      demand -= 1
        //      demand += subscriber.receive(output)
        //    }

        subscriber?.receive(output)
    }
}


extension UIControl {
    
    func publisher(for event: UIControl.Event) -> UIControl.InteractionPublisher {
        return InteractionPublisher(control: self, event: event)
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
        
        func send() {
           _ = self.subscriber.receive(event)
        }
        
        func request(_ demand: Subscribers.Demand) {
           
        }
        
        func cancel() {

        }
    }
}


class CombineTestViewController: UIViewController {

    
    
    var cancellables = Set<AnyCancellable>()
    
    var startButton: UIButton? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.combineTest()
        self.loadTest()
        
        self.loadS()
        self.setupButton()
        
        self.setupControlEventButton()
        self.setupAnyButton()
    }
    
    
    func setupButton() {
        
        let sstartButton = UIButton.init(frame: CGRect.init(x: 240, y: 100, width: 100, height: 100))
        sstartButton.setTitle("Timer", for: .normal)
        sstartButton.addTarget(self, action: #selector(timerS), for: .touchUpInside)
        sstartButton.backgroundColor = .blue
        self.view.addSubview(sstartButton)
        self.startButton = sstartButton
    }
    
    var cancle: AnyCancellable?
    
    func setupControlEventButton() {
        
        let sstartButton = UIButton.init(frame: CGRect.init(x: 10, y: 210, width: 100, height: 100))
        sstartButton.setTitle("ControlEvent", for: .normal)
        cancle = sstartButton.publisher(for: .touchUpInside).sink { ev in
            print("ev = \(ev)")
        }
        sstartButton.backgroundColor = .blue
        self.view.addSubview(sstartButton)
    }
    
    func setupAnyButton() {
        
        let sstartButton = UIButton.init(frame: CGRect.init(x: 120, y: 210, width: 100, height: 100))
        sstartButton.setTitle("Any", for: .normal)
        sstartButton.addTarget(self, action: #selector(AnyTest), for: .touchUpInside)
        sstartButton.backgroundColor = .blue
        self.view.addSubview(sstartButton)
    }
    
    var timerCan: AnyCancellable?
    
    deinit {
//        if let tt = timerCan {
//            tt.cancel()
//        }
    }
    
    @objc
    func AnyTest() {
        print("AnyTest")
        timerCan = Always.init(5).sink { v in
            print("v = \(v)")
        }
        
        
        
        let publisher = [1,2,3,4,5].publisher
        let subscriber = Subscribers.Sink<Int, Never> { e in
            print("e = \(e)")
        } receiveValue: { v in
            print("v = \(v)")
        }
        
        publisher.subscribe(subscriber)
        
    }
    
    @objc
    func timerS() {
        print("abc")
        
        if  let ttimer = timerCan {
            ttimer.cancel()
        }
        self.timeCountDown = 60
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.timerCan = Timer.publish(every: 1, on: .main, in: .commonModes).autoconnect().sink {[weak self] v in
                print("v = \(v)")
                //            if let newV = self?.timeCountDown {
                //                newV -= 1
                //                self?.timeCountDown = newV
                //            }
                self?.timeCountDown -= 1
            }
        }

    }
    
    @objc
    func anyButton() {
        print("anyButton")
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
    
struct EmptyError: Error {
    var info: String?
}
    
struct ParseError: Error {}
    
    func romanNumeral(from:Int) throws -> String {
        let romanNumeralDict: [Int : String] =
        [1:"I", 2:"II", 3:"III", 4:"IV", 5:"V"]
        guard let numeral = romanNumeralDict[from] else {
            throw ParseError()
        }
        return numeral
    }
           
    func ticket(s : NSNumber?) throws -> String {
        if let ss = s {
            return "剩余\(ss)秒"
        }
        throw EmptyError(info: "hhh")
    }
            
    
    let numbers = [5, 4, 3, 2, 1, 0]
    
    func loadS ()
    {
        
        
//        ca = numbers.publisher
//            .tryMap { try self.romanNumeral(from: $0) }
//            .sink(
//                receiveCompletion: {
//                    print ("completion: \($0)")
//
//                },
//                receiveValue: {
//                    print ("abcd  \($0)", terminator: " ")
//
//                }
//             )
        
//        ca = $timeCountDown.flatMap({ str in
//            return str+"当前时间"
//        }).sin { v in
//            print("v = \(v)")
//        }
        
//        let v = $timeCountDown.map { str in
//            return str?+"当前时间"
//        }
//        v.sink { ss in
//            print(ss)
//        }
        
        
        ca = $timeCountDown.map { currentV -> AnyPublisher<String,Never> in
                    let v = currentV.description+"秒"
                    return Just(v).eraseToAnyPublisher()
        }.switchToLatest().sink { str in
            print("str = \(str)")
        }
        
//        ca = $timeCountDown.map { currentV -> AnyPublisher<String,Never> in
//            let v = currentV.description+"秒"
//            return Just(v).eraseToAnyPublisher()
//        }.sink {[weak self] str in
//            print("str = \(str)")
//            self?.startButton?.setTitle(str, for: .normal)
//            self?.startButton?.setTitle(str, for: .disabled)
//        }
        

//        ca = $timeCountDown.map { currentV -> String in
////            return currentV+"秒"
//            let v = currentV+"秒"
//            return v
//        }.sink { str in
//            print("str = \(str)")
//        }
        
        
//        ca = $timeCountDown.tryMap { [weak self] newInt in
//            try self?.ticket(s: newInt)
//        }.sink { ss in
//            print("ss = \(ss)")
//        } receiveValue: { vv in
//            print("vv = \(vv)")
//        }

        
        
//        ca = $timeCountDown
//            .tryMap { str in
//            if let s = str {
//                return s + "acb"
//            } else {
//                throw EmptyError(info: "hhh")
//            }
//            }.sink(receiveCompletion: { e in
//                print(e)
//            }, receiveValue: { <#_#> in
//                <#code#>
//            })
            
        
//        $timeCountDown.tryMap({ str -> AnyPublisher<String, Error> in
//            if let s = str {
//                return( s + "abc").publisher.eraseToAnyPublisher()
//            }
//
//        })
        
//        ca = $timeCountDown.map { str -> String? in
////            return str! + "abc"
//            if let s = str {
//                return s + "acb"
//            }
//            return nil
//        }.replaceNil(with: EmptyError.self)
//        .sink(receiveValue: { v in
//            print(v)
//        })
    }
    
    @Published var timeCountDown: Int = 60
    var ca: AnyCancellable?
    @objc
    func tt()
    {
        
        
        self.timeCountDown = (Int)(Date.timeIntervalBetween1970AndReferenceDate)
        print(self.timeCountDown)
//        $timeCountDown.flatMap { str -> Result<String,Error> in
//            if let _str = str {
//                return Result.success(_str)
//            }
//            return Result.failure()
//        }.sink { value in
//            print(value)
//        }
        
        
//        let c = CC()
//        c.method()
        
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
