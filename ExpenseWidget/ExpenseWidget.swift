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

@main
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
