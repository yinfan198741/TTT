//
//  CombineRetry.swift
//  TT
//
//  Created by FYIN2 on 2023/5/17.
//  Copyright © 2023 fanyin. All rights reserved.
//

import Foundation
import Combine

func combieRetry() -> AnyPublisher<warpPerson, Error> {
    
    return mockURLBack().tryMap {  data in
        do {
            let warp_Person = try JSONDecoder().decode(warpPerson.self, from: data)
            return warp_Person
        } catch  {
            throw error
        }
    }.eraseToAnyPublisher()
    
    
    //    mockURLBack().map { data in
    //        let warp_Person =  try JSONDecoder().decode(warpPerson.self, from: data)
    //        return Result.success(warp_Person).publisher.setFailureType(to: Never.self).eraseToAnyPublisher()
    
        
//    return mockURLBack()
//        .decode(type: warpPerson.self, decoder: JSONDecoder())
//        .eraseToAnyPublisher()
}


func mockURLBack() -> AnyPublisher<Data, Error> {
   let publish = Future<Data, Error>{ promise in
        let info =
        """
        {"userName":"yinfan", "userAge": "36", "school": "pixian middel school" }
        """
       let data = info.data(using: String.Encoding.utf8)
       promise(.success(data!))
    }.eraseToAnyPublisher()
    return publish
}

//struct warpPerson : Codable {
//    var userName: String
//    var userAge: Int
//    var school: String
//}


struct warpPerson : Codable {
//    @myDefault_d<String>  var userName: String
//    @myDefault_d<String>  var school: String

    @myDefault_d<Int>     var userAge: Int
}
