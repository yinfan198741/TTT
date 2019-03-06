//
//  functionPrograme.swift
//  SwiftTest
//
//  Created by 尹凡 on 3/24/18.
//  Copyright © 2018 尹凡. All rights reserved.
//

import Foundation


enum GenderType {
    case boy
    case girl
}

struct Student{
    let name: String
    let gender: GenderType
    let source: Float
}

extension Student : Comparable {
    static func ==(lhs: Student, rhs: Student) -> Bool {
        return false
    }
    
    static func < (lhs: Student, rhs: Student) -> Bool {
        return lhs.source < rhs.source
    }
}


struct School {
    let students = [
        Student(name: "Make", gender: .boy, source: 75.0),
        Student(name: "Jason", gender: .boy, source: 80.0),
        Student(name: "Lucy", gender: .girl, source: 82.0),
        Student(name: "Lili", gender: .girl, source: 83.0),
        Student(name: "Amy", gender: .girl, source: 70.0),
        Student(name: "Jenny", gender: .girl, source: 72.0),
        Student(name: "Kelly", gender: .girl, source: 90.0),
        Student(name: "Helen", gender: .girl, source: 170.0),
    ]
    
    
    
    
    mutating func Test() {
//        let girlsName = getUpScoreName(studets: students, type: .girl)
//        print(girlsName)
        let girlsName =  getUpScoreNameFC(studets: students, type: .girl)
        print(girlsName)
        
//        getFlowerToStudent(studets: Student,countTotal: 3)
        
//        getFlowerToStudent(studets: self.students, countTotal: 3)
        
        getFlowerToStudentFC(studets: self.students, countTotal: 3)
        
    }
    
    
    mutating func flower() {
        getFlowerToStudentFC(studets: self.students, countTotal: 3)
    }
    
    
    func getUpScoreName(studets : [Student] , type: GenderType)-> [String] {
        
       var genderStudent = [Student]()
       var genderName = [String]()

       for i in 0..<studets.count {
            if studets[i].gender == type {
                genderStudent.append(studets[i])
            }
        }
        
        for i in 0..<genderStudent.count {
            let stu = genderStudent[i]
            //2
            for j in stride(from: i, to: -1, by: -1){
                if stu.source < genderStudent[j].source {
                    genderStudent.remove(at: j + 1)
                    genderStudent.insert(stu, at: j)
                }
            }
        }
        
        for i in 0..<genderStudent.count {
            genderName.append(genderStudent[i].name)
        }
        
        return genderName
    }
    
    func getUpScoreNameFC(studets : [Student] , type: GenderType) -> [String] {
        let names = studets.filter{ $0.gender == type }.sorted{ $0 < $1 }.map{ return $0.name }
        return names
    }
    
    
    var count = 0

    mutating func getFlowerToStudent(studets : [Student] , countTotal: Int) {

        self.count = countTotal

        let max = UInt32(studets.count)
        while count > 0 {
            let index =  Int(arc4random() % max)
            count = count - 1
            print(studets[index])
        }
    }
    
    func getFlowerToStudentFC(studets : [Student], countTotal: Int) {
        if (countTotal == 0) {
            return
        }else {
            let index =  Int(arc4random() %  UInt32(studets.count))
            print(studets[index])
            self.getFlowerToStudentFC(studets: studets, countTotal: countTotal - 1)
        }
    }
    
}


enum RideType {
    case Family
    case Thrill
    case Water
    case Kids
    case Scary
    case Relaxing
}

struct Ride{
    let name:String
    let types:[RideType]
    let waitTime:Float
    
}



struct FP {
    
    let parkRides = [
        Ride(name: "Raging Rapids", types: [.Family, .Thrill, .Water], waitTime: 45.0),
        Ride(name: "Crazy Funhouse", types: [.Family], waitTime: 10.0),
        Ride(name: "Spinning Tea Cups", types: [.Kids], waitTime: 15.0),
        Ride(name: "Spooky Hollow", types: [.Scary], waitTime: 30.0),
        Ride(name: "Thunder Coaster", types: [.Family, .Thrill], waitTime: 60.0),
        Ride(name: "Grand Carousel", types: [.Family, .Kids], waitTime: 15.0),
        Ride(name: "Bumper Boats", types: [.Family, .Water], waitTime: 25.0),
        Ride(name: "Mountain Railroad", types: [.Family, .Relaxing], waitTime: 0.0)
    ]
    
    func Test() {
        let name = sortedNames(rides: parkRides)
        print(name)
    }
    
    func sortedNames(rides: [Ride]) -> [String] {
        var sortedRides = rides
        //1
        for i in 0..<sortedRides.count {
            let key = sortedRides[i]
            //2
            for j in stride(from: i, to: -1, by: -1){
                if key.name.localizedCompare(sortedRides[j].name) == .orderedAscending {
                    sortedRides.remove(at: j + 1)
                    sortedRides.insert(key, at: j)
                }
            }
        }
        // 1
        //    for (var i = 0; i < sortedRides.count; i++) {
        //        key = sortedRides[i]
        //
        //        // 2
        //        for (var j = i; j > -1; j--) {
        //            if key.name.localizedCompare(sortedRides[j].name) == .orderedAscending {
        //                sortedRides.removeAtIndex(j + 1)
        //                sortedRides.insert(key, atIndex: j)
        //            }
        //        }
        //    }

//        // 3
        var sortedNames = [String]()
        for ride in sortedRides {
            sortedNames.append(ride.name)
        }

        print(sortedRides)
      
        return sortedNames
    }
    
    func waitTimeIsShort(ride: Ride) -> Bool {
        return ride.waitTime < 15.0
    }
    
    
    func timeShort() {
//        let shortWaitTimeRides = parkRides.filter(waitTimeIsShort)
         let  shortWaitTimeRides = parkRides.filter{ $0.waitTime < 15.0}
        print(shortWaitTimeRides)
    
    }
    
    func nameMap(){
        let rideNames = parkRides.map { $0.name }
        print(rideNames)
//        print(rideNames.sort{by:$0<$1 return true})
    }
    
    
    
//    func rideTypeFilter(type: Ride, fromRides rides: [Ride]) -> [Ride] {
//        return rides.filter { $0.types.contains(type) }
//    }

//    func createRideTypeFilter(type: RideType) -> [Ride] -> [Ride] {
//        return rideTypeFilter(type)
//    }

    
//    func rideTypeFilter(type: RideType)(fromRides rides: [Ride]) -> [Ride] {
//        return rides.filter { $0.types.contains(type) }
//    }
//
//
//    func createRideTypeFilter(type: RideType) -> ([Ride]) -> [Ride] {
//        return rideTypeFilter(rides: type)
//    }
    
    func rideTypeFilter(type: RideType)-> ([Ride]) -> [Ride] {
        func filtRes(rides: [Ride])-> [Ride]{
            return rides.filter { $0.types.contains(type) }
        }
        return filtRes
    }
    
    func cuyTest(){
        print("cuyTest")
        let filter = rideTypeFilter(type: .Relaxing)
        let kids = filter(parkRides)
        print(kids)
    }
    
//    //纯函数
//    func add_pure(a: Int) -> Int {
//        return a + 1
//    }
//
//    var b = 0;
//    func add_nopure(a: Int) -> Int {
//        return a + b
//    }
    
}
