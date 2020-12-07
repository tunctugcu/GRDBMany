//
//  ImportantLine.swift
//  GRDBMany
//
//  Created by Tunc Tugcu on 7.12.2020.
//

import Foundation
import GRDB

struct ImportantLine: Codable, FetchableRecord, MutablePersistableRecord {
    var id: Int64?
    var bookId: Int64
    var line: Int64
    
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
    
    static let book = belongsTo(Book.self)
    
    var book: QueryInterfaceRequest<Book> {
        return request(for: Self.book)
    }
}
