//
//  ExpenseWidget.swift
//  ExpenseWidget
//
//  Created by Grace Rufina Solibun on 1/11/2023.
//

import WidgetKit
import SwiftUI
import CoreData

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> ExpenseWidgetEntry {
        let container = NSPersistentContainer(name: "Expense")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error)")
            }
        }

        // Insert sample data into Core Data
        let context = container.viewContext

        let sampleExpense1 = Expense(context: context)
        sampleExpense1.name = "Zara"
        sampleExpense1.amount = 10
        sampleExpense1.timestamp = Date()

        let sampleExpense2 = Expense(context: context)
        sampleExpense2.name = "Pizza Hut"
        sampleExpense2.amount = 20
        sampleExpense2.timestamp = Date()

        // Save the changes to Core Data
        do {
            try context.save()
        } catch {
            fatalError("Error saving sample data: \(error)")
        }

        // Fetch the sample data from Core Data
        let placeholderData = fetchDataFromCoreData()

        // Create a placeholder entry with the current date and the sample data
        let placeholderEntry = ExpenseWidgetEntry(date: Date(), data: placeholderData)

        return placeholderEntry
    }

    
    
    
    
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Expense")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error)")
            }
        }
    }

    func fetchDataFromCoreData() -> [Expense] {
        let context = container.viewContext

        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()

        // Sort expenses by timestamp in descending order
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]

        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching expenses: \(error)")
            return []
        }
    }

    func getSnapshot(in context: Context, completion: @escaping (ExpenseWidgetEntry) -> ()) {
        let data = fetchDataFromCoreData()
        let entry = ExpenseWidgetEntry(date: Date(), data: data)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<ExpenseWidgetEntry>) -> ()) {
        let data = fetchDataFromCoreData()
        let entry = ExpenseWidgetEntry(date: Date(), data: data)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct ExpenseWidgetEntry: TimelineEntry {
    let date: Date
    let data: [Expense]
}

struct ExpenseWidgetView: View {
    let data: [Expense]

    var body: some View {
        VStack {
            Text("Expense Widget")
                .font(.title)

            List(data, id: \.self) { expense in
                HStack {
                    Text(expense.name ?? "Unknown")
                    Spacer()
                    Text("$\(expense.amount)")
                }
            }
        }
        .padding()
    }
}

//@main
struct ExpenseWidget: Widget {
    let kind: String = "ExpenseWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ExpenseWidgetView(data: entry.data)
        }
        .configurationDisplayName("Expense Widget")
        .description("Display expenses from Core Data.")
    }
}
