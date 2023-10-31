//
//  FetchWidgetsData.swift
//  IOS_Advanced_Assignment_4
//
//  Created by Grace Rufina Solibun on 31/10/2023.
//

import Foundation
import CoreData

// Create a function to fetch expenses grouped by category
func fetchExpensesGroupedByCategory() -> [String: [(name: String, amount: Int)]] {
    let context = PersistenceController.shared.container.viewContext

    let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
    
    // Sort expenses by creationDate in descending order
    let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
    fetchRequest.sortDescriptors = [sortDescriptor]

    do {
        let expenses = try context.fetch(fetchRequest)

        // Use Swift to group expenses by category
        let groupedExpenses = Dictionary(grouping: expenses, by: { $0.category })

        // Sort and format data as needed (e.g., calculate total amounts)
        var formattedData: [String: [(name: String, amount: Int)]] = [:]
        for (category, expenses) in groupedExpenses {
            let topThreeLatestExpenses = Array(expenses.prefix(3)) // Select the top three latest expenses
            let totalAmount = topThreeLatestExpenses.reduce(0) { $0 + Int($1.amount) }

            formattedData[category ?? "Unknown"] = topThreeLatestExpenses.map { ($0.name ?? "Unknown", Int($0.amount)) }
        }

        return formattedData
    } catch {
        print("Error fetching expenses: \(error)")
        return [:]
    }
}
