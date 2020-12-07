//
//  Book.swift
//  GRDBMany
//
//  Created by Tunc Tugcu on 7.12.2020.
//

import Foundation
import GRDB

struct Book: Codable, FetchableRecord, MutablePersistableRecord {
    var id: Int64?
    var authorId: Int64
    var name: String
    
    static let author = belongsTo(Author.self)
    
    var author: QueryInterfaceRequest<Author> {
        return request(for: Self.author)
    }
    
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}
