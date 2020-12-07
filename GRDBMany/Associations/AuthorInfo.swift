//
//  AuthorInfo.swift
//  GRDBMany
//
//  Created by Tunc Tugcu on 7.12.2020.
//

import Foundation
import GRDB

struct AuthorInfo: Decodable, FetchableRecord {
    static let request = Author.including(optional: Author.book)
    
    let author: Author
    let book: Book?
}
