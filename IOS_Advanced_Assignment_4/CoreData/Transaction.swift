//
//  Transaction.swift
//  IOS_Advanced_Assignment_4
//
//  Created by vinay bayyapunedi on 31/10/23.
//

import Foundation


struct Transaction: Codable, Hashable, Identifiable {
    
    var id: Int
    var category: String
}
