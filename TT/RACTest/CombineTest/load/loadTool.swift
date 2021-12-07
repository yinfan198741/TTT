//
//  loadTool.swift
//  TT
//
//  Created by Fan Yin on 2021/12/6.
//  Copyright © 2021 fanyin. All rights reserved.
//

import Foundation
import Combine


///测试崩溃
///combine

//https://swiftrocks.com/whats-type-and-self-swift-metatypes.html
//https://learnappmaking.com/self-swift-how-to/

//https://www.swiftbysundell.com/articles/under-the-hood-of-futures-and-promises-in-swift/




struct LoadUser : Codable {
    var name: String
    var age : Int
}

struct LoadUserError : Error
{
    var info: String
}


protocol loadFileUserProtocal {
    associatedtype fileUserType
    func loadFile() -> Result<fileUserType, Error>
}


protocol loadNetUserProtocal {
    associatedtype netUserType
    func loadNet() -> Result<netUserType, Error>
}


struct loadFileTool <FfileUserType> : loadFileUserProtocal where FfileUserType: Codable{
    typealias fileUserType = FfileUserType
    func loadFile() -> Result<fileUserType, Error> {
        
        let str =
            """
            {
                "name": "yinfan_file",
                "age" : 18
            }
            """
            .data(using: .utf8)
        
        let decoder = JSONDecoder.init()
        
        if let data = str , let user = try? decoder.decode(fileUserType.self, from: data){
            return .success(user)
        }
        
        
        
        return .failure(LoadUserError(info: "loadFileTool"))
    }
}

struct loadNetTool<LnetUserType> : loadNetUserProtocal where LnetUserType : Codable{
    
    typealias netUserType = LnetUserType
    
    func loadNet() -> Result<netUserType, Error> {
        
        let str =
                        """
                        {x
                            "name": "yinfan_net",
                            "age" : 18
                        }
                        """
            .data(using: .utf8)
        
        let decoder = JSONDecoder.init()
        
        if let data = str , let user = try? decoder.decode(netUserType.self, from: data){
            return .success(user)
        }
        
        
        
        return .failure(LoadUserError(info: "loadNetTool"))
    }
    
}

struct Tcancel {
   static var cancellables = Set<AnyCancellable>()
}




struct LoadTool<FileUser : Codable, NetUser : Codable> {
    
    var localUser : loadFileTool<FileUser>
    var netUser : loadNetTool<NetUser>
    
    
    func test() {
//        let str =
//            """
//            {
//                "name": "yinfan",
//                "age" : 18
//            }
//            """
//            .data(using: .utf8)
//
//        let decoder = JSONDecoder.init()
//
//        if let data = str {
//            do {
//             let user =  try decoder.decode(LoadUser.self, from: data)
//                print("user = \(user)")
//            } catch let err {
//                print("err = \(err)")
//            }
//        }https://www.donnywals.com/configuring-error-types-when-using-flatmap-in-combine/
        
        
        let someURL = URL.init(string: "https://www.baidu.com")
        URLSession.shared.dataTaskPublisher(for: someURL!).sink { e in
            print("e = \(e)")
        } receiveValue: { v in
            print("v = \(v)")
        }.store(in: &Tcancel.cancellables)

        
//        let v =  URLSession.shared.dataTaskPublisher(for: someURL!).map { t in
//            return t
//        }
//    https://www.donnywals.com/configuring-error-types-when-using-flatmap-in-combine/
        URLSession.shared.dataTaskPublisher(for: someURL!)
            .mapError({ t in
               return t as Error
            })
          .flatMap({ output -> AnyPublisher<Data, Error> in
              return Just("abc".data(using: .utf8)!)
                  .setFailureType(to: Error.self)
                  .eraseToAnyPublisher()
          })
        
//          .flatMap({ output -> AnyPublisher<Data, Error> in
//
//          })
        
    }
}


extension LoadTool where FileUser == NetUser
{
    func fetchUser() -> AnyPublisher<FileUser, Error> {

        let fUser = Future<FileUser , Error> { p in
            let user = localUser.loadFile()
            switch user {
            case let .success(user):
                p(.success(user))
            case let .failure(error):
                p(.failure(error))
            }
        }.map { t in
            return t
        }
        
        
        let NUser = Future<NetUser , Error> { p in
            let user = netUser.loadNet()
            switch user {
            case let .success(user):
                p(.success(user))
            case let .failure(error):
                p(.failure(error))
            }
        }
        
//        fUser.subscribe(on: <#T##Scheduler#>, options: <#T##Scheduler.SchedulerOptions?#>)
//        return fUser.flatMap { s in
//            return s
//        }
//        fUser.flatMap { fileUser in
//
//        }
//        Future.zip(<#T##self: Future<_, _>##Future<_, _>#>)
        
//        return fUser.flatMap { t in
//
//        }.eraseToAnyPublisher()
          
//        return fUser.flatMap { t in
//            return Just(t).mapError { n in
//                return LoadUserError(info: "TTT")
//            }
//        }.eraseToAnyPublisher()
        
//        return fUser.map { e in
//            return NUser
//        }.eraseToAnyPublisher()
        
      return  fUser.tryCatch { e in
          return NUser.tryCatch { e in
              return Just(LoadUser(name: "failed", age: 0) as! FileUser)
          }
        }.eraseToAnyPublisher()
        
//     return fUser.map { t in
//          return  Just(t)
//        }.eraseToAnyPublisher()
    }
}


// https://www.swiftbysundell.com/articles/under-the-hood-of-futures-and-promises-in-swift/
//    func loadFile() -> Result<LoadUser.Type, Error> {
////        FileManager.default.currentDirectoryPath
//        var str =
//            """
//            {
//                name: "yinfan"
//                age : 18
//            }
//            """
//            .data(using: .utf8)
//
//        let user = JSONDecoder.init().decode(LoadUser.Type, from: str?)
//
//
//    }
    
//    func loadNet() -> Result<LoadUser.Type, Error> {
//
//    }
    
//}

