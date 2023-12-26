//
//  typeEraseViewController.swift
//  TT
//
//  Created by FYIN2 on 2023/12/25.
//  Copyright © 2023 fanyin. All rights reserved.
//

import UIKit


protocol animal {
    associatedtype food
    associatedtype rust
    func eat(f: food) -> rust
}

struct peopleRice {}

struct peopleRust {}

struct dogRice {}

struct dogRust {}

class typePerson :animal {
    func eat(f: peopleRice) -> peopleRust{
        print("typePerson eat f = \(f)")
        return peopleRust()
    }
}

class typeDog: animal {
    func eat(f: dogRice) -> dogRust{
        print("typeDog eat f = \(f)")
        return dogRust()
    }
}

class anyAnimal {
    var warpEat : (Any)-> Any
    init<T :animal>(ani: T) {
        self.warpEat = { item in
            guard let ff =  item as? T.food else{
                fatalError()
            }
           return ani.eat(f: ff)
        }
    }
    func anyEat(tt: Any)-> Any {
       return self.warpEat(tt)
    }
}


class typeEraseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let b = UIButton.init(frame: CGRect(x: 10, y: 10, width: 200, height: 50))
        b.setTitle("typeErase", for: .normal)
        b.setTitleColor(.blue, for: .normal)
        b.addTarget(self, action: #selector(typeEraseAdd), for: .touchUpInside)
        self.view.addSubview(b)
        // Do any additional setup after loading the view.
    }
    
    @objc
    func typeEraseAdd() {
        print("typeEraseAdd")
        
        let po = typePerson()
        print(po.eat(f: peopleRice()))
        
        
        let dog = typeDog()
        print(dog.eat(f: dogRice()))
        
        
        print("typeErase=====")
        
        let anyAnimal_1 = anyAnimal(ani: po)
        print(anyAnimal_1.anyEat(tt: peopleRice()))
        
        
        let anyAnimal_2 = anyAnimal(ani: dog)
        print(anyAnimal_2.anyEat(tt: dogRice()))
        
        
        print("for in items =====")
        let animals:[any animal] = [po,dog]
        
        for item in animals {
            switch item {
            case let item as typePerson:
                print(item)
                
            case let item as typeDog:
                print(item)
            default:
                print(item)
            }
        }
        
        
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
