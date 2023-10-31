//
//  Transaction.swift
//  IOS_Advanced_Assignment_4
//
//  Created by vinay bayyapunedi on 31/10/23.
//

import Foundation

struct Transaction: Codable, Hashable, Identifiable {
    
    var id: UUID // Use UUID for id
    var name: String
    var amount: Int
    var timestamp: Date
    var category: String
    
//    init(name: String, amount: Int, category: String) {
//        self.id = UUID() // Generate a new UUID
//        self.name = name
//        self.amount = amount
//        self.timestamp = Date()
//        self.category = category
//    }
    
    init(id: UUID, name: String, amount: Int, category: String, timestamp: Date) {
        self.id = id
        self.name = name
        self.amount = amount
        self.timestamp = timestamp
        self.category = category
    }
}
