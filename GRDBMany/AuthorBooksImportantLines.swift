//
//  AuthorBooksImportantLines.swift
//  GRDBMany
//
//  Created by Tunc Tugcu on 7.12.2020.
//

import Foundation
import GRDB

struct AuthorBooksImportantLines: Decodable, FetchableRecord {
    static let request = Author
        .including(optional: Author.book.including(all: Book.importantLines))
        
    let author: Author
    let book: BookWithImportantLines?
}

struct BookWithImportantLines: Decodable, FetchableRecord {
    static let request = Book.including(all: Book.importantLines)
    
    let book: Book
    let importantLines: [ImportantLine]
}
