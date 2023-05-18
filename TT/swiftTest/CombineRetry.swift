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
    case retryAble
    case failed
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
    return
    mockURLBack().tryCatch { error in
        if error == .retryAble {
            return Just(Void())
                .delay(for: .seconds(10) , scheduler: DispatchQueue.main)
                .flatMap { _ in
                    return mockURLBack()
                }
        }
        throw error
    }
    .decode(type: warpPerson.self, decoder: JSONDecoder())
    .retry(3)
    .eraseToAnyPublisher()
}


var index:Int = 0

func mockURLBack() -> AnyPublisher<Data, myNetWorkError> {
    index = index + 1
    index = index % 3
    let publish = Future<Data, myNetWorkError>{ promise in
        
        if index == 0 {
            promise(.failure(.retryAble))
        } else {
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
