//
//  FetchWidgetsData.swift
//  IOS_Advanced_Assignment_4
//
//  Created by Grace Rufina Solibun on 31/10/2023.
//

import Foundation
import CoreData
import WidgetKit

class WidgetDataProvider: ObservableObject {
    private var container: NSPersistentContainer
    @Published var expensesData: [WidgetsData] = []

    init(container: NSPersistentContainer) {
        self.container = container
        fetchExpensesGroupedByCategory()
    }

    func fetchExpensesGroupedByCategory() {
        let context = container.viewContext

        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
        
        // Sort expenses by timestamp in descending order
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]

        do {
            let expenses = try context.fetch(fetchRequest)

            // Use Swift to group expenses by category
            let groupedExpenses = Dictionary(grouping: expenses, by: { $0.category ?? "Unknown" })

            // Format data into WidgetExpenseData
            var formattedData: [WidgetsData] = [] // Update this line

            for (category, expenses) in groupedExpenses {
                let topThreeLatestExpenses = expenses.prefix(3) // Select the top three latest expenses
                let categoryExpenses = topThreeLatestExpenses.map {
                    (name: $0.name ?? "Unknown", amount: Int($0.amount))
                }

                let widgetExpenseData = WidgetsData(category: category, topThreeExpenses: categoryExpenses)
                formattedData.append(widgetExpenseData)
            }

            expensesData = formattedData
        } catch {
            print("Error fetching expenses: \(error)")
        }
    }
}





//import WidgetKit
//import CoreData
//
//class WidgetDataProvider: ObservableObject {
//    private var container: NSPersistentContainer
//    @Published var expensesData: [WidgetsData] = []
//
//    init(container: NSPersistentContainer) {
//        self.container = container
//    }
//
//    func fetchExpensesGroupedByCategory() {
//        let context = container.viewContext
//
//        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
//
//        // Sort expenses by timestamp in descending order
//        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//
//        do {
//            let expenses = try context.fetch(fetchRequest)
//
//            // Use Swift to group expenses by category
//            let groupedExpenses = Dictionary(grouping: expenses, by: { $0.category ?? "Unknown" })
//
//            // Format data into WidgetExpenseData
//            var formattedData: [WidgetsData] = []
//
//            for (category, expenses) in groupedExpenses {
//                let topThreeLatestExpenses = expenses.prefix(3) // Select the top three latest expenses
//                let categoryExpenses = topThreeLatestExpenses.map {
//                    (name: $0.name ?? "Unknown", amount: Int($0.amount))
//                }
//
//                let widgetExpenseData = WidgetsData(category: category, topThreeExpenses: categoryExpenses)
//                formattedData.append(widgetExpenseData)
//            }
//
//            expensesData = formattedData
//        } catch {
//            print("Error fetching expenses: \(error)")
//        }
//    }
//}
//
//extension WidgetDataProvider: TimelineProvider {
//    func placeholder(in context: Context) -> WidgetsData {
//        // Return a placeholder data for your widget here
//        return WidgetsData(category: "Placeholder", topThreeExpenses: [("Expense 1", 10), ("Expense 2", 20), ("Expense 3", 30)])
//    }
//
//    func getSnapshot(in context: Context, completion: @escaping (WidgetsData) -> ()) {
//        // Fetch data for your widget snapshot and call the completion handler
//        fetchExpensesGroupedByCategory()
//        completion(expensesData.first ?? placeholder(in: context))
//    }
//
//    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetsData>) -> ()) {
//        // Fetch data for your widget timeline entries and create a timeline
//        fetchExpensesGroupedByCategory()
//
//        let currentDate = Date()
//        let timeline = Timeline(entries: [expensesData.first ?? placeholder(in: context)], policy: .atEnd)
//        completion(timeline)
//    }
//}
