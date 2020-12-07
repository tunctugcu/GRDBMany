//
//  Author.swift
//  GRDBMany
//
//  Created by Tunc Tugcu on 7.12.2020.
//

import Foundation
import GRDB

struct Author: Codable, FetchableRecord, MutablePersistableRecord {
    var id: Int64?
    var name: String
    
    
    static let books = hasMany(Book.self)
    
    var books: QueryInterfaceRequest<Book> {
        return request(for: Self.books)
    }
    
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
    
}
