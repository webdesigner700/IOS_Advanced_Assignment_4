//
//  Transaction.swift
//  IOS_Advanced_Assignment_4
//
//  Created by vinay bayyapunedi on 31/10/23.
//

import Foundation


struct Transaction: Codable, Hashable, Identifiable {
    
    var id: Int
    var name: String
    var amount: Int
    var addTime: Date
    var category: String
    
    init(name: String, amount: Int, category: String) {
        
        self.id = Int.random(in: 1...50)
        self.name = name
        self.amount = amount
        self.addTime = Date()
        self.category = category
    }
}
