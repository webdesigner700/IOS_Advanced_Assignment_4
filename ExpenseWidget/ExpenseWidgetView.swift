//
//  ExpenseWidgetView.swift
//  IOS_Advanced_Assignment_4
//
//  Created by Grace Rufina Solibun on 1/11/2023.
//

import SwiftUI

struct ExpenseWidgetView: View {
    let data: [Expense]

    var body: some View {
        // Create a view to display your data
        List(data, id: \.self) { expense in
            Text(expense.name ?? "Unknown")
            Text("$\(expense.amount)")
        }
    }
}
