//
//  WidgetsData.swift
//  IOS_Advanced_Assignment_4
//
//  Created by Grace Rufina Solibun on 1/11/2023.
//

import Foundation
import WidgetKit

struct WidgetsData: Identifiable {
    var id = UUID()
    
    var category: String
    var topThreeExpenses: [(name: String, amount: Int)]
}
