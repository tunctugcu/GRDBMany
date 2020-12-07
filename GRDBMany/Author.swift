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
    
    
    static let book = hasOne(Book.self)
    
    var book: QueryInterfaceRequest<Book> {
        return request(for: Self.book)
    }
    
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
    
}
