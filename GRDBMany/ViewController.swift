//
//  ViewController.swift
//  GRDBMany
//
//  Created by Tunc Tugcu on 7.12.2020.
//

import UIKit
import GRDB

final class ViewController: UIViewController {
    
    private lazy var databaseURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("test.sqlite")
    private lazy var pool = try! DatabasePool(path: databaseURL.path)
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        try? FileManager.default.removeItem(at: databaseURL)
        
        do {
            try createTable()
            try insertTestRecords()
            try readRecords()
        } catch {
            print(error.localizedDescription)
        }
    }
}


// MARK: - Setup Helpers
extension ViewController {
    private func createTable() throws {
        try pool.write { db in
            
            // Create author
            try db.create(table: "author") { (t) in
                t.autoIncrementedPrimaryKey("id")
                t.column("name", .text).notNull().check{ length($0) > 0 }
            }
            
            // Create book
            try db.create(table: "book") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("authorId", .integer)
                    .indexed()
                    .references("author", onDelete: .cascade)
                    .notNull()
                t.column("name", .text).notNull().check{ length($0) > 0 }
            }
            
        }
    }
    
    private func insertTestRecords() throws {
        try pool.write { db in
            var author = Author(id: nil, name: "Tunc")
            try author.save(db)
            var book1 = Book(id: nil, authorId: author.id!, name: "Book 1")
            
            try book1.save(db)
            
            var book2 = Book(id: nil, authorId: author.id!, name: "Book 2")
            
            try book2.save(db)
        }
    }
    
    
    private func readRecords() throws {
        let request = AuthorInfo.request
        
        let results = try pool.read { db in
            try AuthorInfo.fetchAll(db, request)
        }
        
        print(results)
    }
    
}

