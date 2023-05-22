//
//  CombineRetry.swift
//  TT
//
//  Created by FYIN2 on 2023/5/17.
//  Copyright © 2023 fanyin. All rights reserved.
//

import Foundation
import Combine

enum myNetWorkError: Error {
    case retryToken
    case retryAbles
    case failed
    case fatileError
}


func combieRetryPublisher() -> AnyPublisher<warpPerson, Error> {
    //    return mockURLBack().tryMap {  data in
    //        do {
    //            let warp_Person = try JSONDecoder().decode(warpPerson.self, from: data)
    //            return warp_Person
    //        } catch  {
    //            throw error
    //        }
    //    }.eraseToAnyPublisher()
    //
    
//    let pub: AnyPublisher<warpPerson, Publishers.Decode<AnyPublisher<Data, myNetWorkError>, warpPerson, JSONDecoder>.Failure>  = mockURLBack()
//        .decode(type: warpPerson.self, decoder: JSONDecoder())
//        .eraseToAnyPublisher()
//    return pub

    let pub  = mockURLBack()
        .tryCatch({ error in
            if error == .retryToken {
                let pub = Just(Void()).flatMap { _ in
                    return mockRefreshTokenURLBack().map { v in
                        return Data()
                    }
                }.tryCatch { error in
                    
                    if error == .fatileError {
                        throw error
                    }
                    return mockURLBack()
                }
                let pube = pub.eraseToAnyPublisher()
                return pube
            }
            throw error
        })
        .tryCatch({ error in

            if let e = error as? myNetWorkError ,
               e == .retryAbles {
                throw e
            }
            
//             if error == myNetWorkError.retryAbles {
//                throw error
//            }

            let pub = Just(Void())
                .setFailureType(to: myNetWorkError.self)
                .delay(for: .seconds(5), scheduler: DispatchQueue.main)
                .flatMap { _ in
                    return mockURLBack()
                }.retry(3)
                .eraseToAnyPublisher()

            return pub
        }).flatMap({ data -> AnyPublisher<warpPerson, Error> in
            let warp_Person = try! JSONDecoder().decode(warpPerson.self, from: data)
            return Just(warp_Person).setFailureType(to: Error.self).eraseToAnyPublisher()
        })

//        .decode(type: warpPerson.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    return pub
    
//    return mockURLBack().catch { error in
//        if error == .retryAble {
//            return Just(Void())
//                .delay(for: .seconds(10) , scheduler: DispatchQueue.main)
//                .flatMap { _ in
//                    return mockURLBack()
//                }
//        } else if error == .retryToken {
//
//            return mockURLBack()
////            return Just(Void())
////                .flatMap { () -> AnyPublisher<Data, myNetWorkError> in
////                    return mockURLBack()
////                }
//
//            //            return Just(true)
//            //                .catch({ error in
//            //                    return mockRefreshTokenURLBack()
//            //                })
//            //                .tryCatch { error in
//            //                    throw error
//
////          return
//
////            Just(true).map { v -> AnyPublisher<Bool, myNetWorkError> in
////                return mockRefreshTokenURLBack().map { b in
////                    return mockURLBack()
////                }
////            }
//
////            Just(true)
////                .flatMap { v -> AnyPublisher<Bool, myNetWorkError> in
////                    return mockRefreshTokenURLBack()
////                }.tryCatch({ errpr -> AnyPublisher<Data, myNetWorkError>in
////                    return  mockURLBack()
////                })
//
//
//
//
////            Just(true)
////                .flatMap { _ in
////                return mockRefreshTokenURLBack()
////            }.tryCatch { error in
////                throw error
////            }
//        }
//
//    }
//    .decode(type: warpPerson.self, decoder: JSONDecoder())
//    .retry(3)
//    .eraseToAnyPublisher()
}


var index:Int = 0

func mockURLBack() -> AnyPublisher<Data, myNetWorkError> {
    index = index + 1
    index = index % 4
    let publish = Future<Data, myNetWorkError>{ promise in
        
        if index == 0 {
            promise(.failure(.retryAbles))
        }
        else if index == 4 {
            promise(.failure(.retryToken))
        }
        else {
            let info =
            """
            {"name":"yinfan", "age": 36, "school": "pixian middel school" }
            """
            let data = info.data(using: String.Encoding.utf8)
            promise(.success(data!))
        }
    }.eraseToAnyPublisher()
    return publish
}

var indexRT: Int = 0
func mockRefreshTokenURLBack() -> AnyPublisher<Bool, myNetWorkError> {
    indexRT = indexRT + 1
    indexRT = indexRT % 3
    let publish = Future<Bool, myNetWorkError>{ promise in
        if index == 0 {
            promise(.failure(.retryAbles))
        } else {
            promise(.success(true))
        }
    }.eraseToAnyPublisher()
    return publish
}

//struct warpPerson : Codable {
//    var userName: String
//    var userAge: Int
//    var school: String
//}



struct warpPerson: Decodable {
    @Default<String> var name: String
    @Default<Int> var age: Int
    @Default<String> var school: String
    @Default<String> var street: String
    @Default<Int> var postNumber: Int
}
