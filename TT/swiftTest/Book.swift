//
//  Book.swift
//  TT
//
//  Created by 尹凡 on 3/5/19.
//  Copyright © 2019 fanyin. All rights reserved.
//

import Foundation


class Book {
  var name:String?
  var price: Int?
  init?(name:String?, price: Int?) {
    self.name = name
    self.price = price
  }
}




class BookIterator: IteratorProtocol {
  typealias Element = Book
  var count:Int
  init() {
    count = 3
  }
  func next() -> Book? {
    if count > 0 {
      count = count-1
       return Book(name: "test", price: count)
    }
    else {
      return nil
    }
  }
}

class BookList: Sequence {
  typealias Iterator = BookIterator
  public func makeIterator() -> Iterator {
    return BookIterator()
  }
}


class BookTest {
  func Test()  {
    let bookList: BookList = BookList()
    for book in bookList {
      print(book.name,book.price)
    }
  
    let filterlist = bookList.filter{ $0.name?.count ?? 0 > 5}
    let b = filterlist.first
    
    let lazyfilterlist = bookList.lazy.filter { $0.name?.count ?? 0 > 5}
    let b2 = lazyfilterlist.first
    
    for (index, book) in bookList.enumerated() {
    
    }
    
  }
}


