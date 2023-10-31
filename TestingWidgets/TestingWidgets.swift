//
//  TestingWidgets.swift
//  TestingWidgets
//
//  Created by Grace Rufina Solibun on 1/11/2023.
//

import WidgetKit
import SwiftUI
import CoreData

struct Provider: TimelineProvider {
//    func placeholder(in context: Context) -> SimpleEntry {
//        SimpleEntry(date: Date())
//    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), expensesData: [])
    }

//    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//        let entry = SimpleEntry(date: Date())
//        completion(entry)
//    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let placeholderEntry = SimpleEntry(date: Date(), expensesData: [])
        completion(placeholderEntry)
    }

//    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
//    }
    
    // Initialize the WidgetDataProvider with the CoreData container
    let dataProvider = WidgetDataProvider(container: PersistenceController.shared.container)

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let date = Date()

        // Use your WidgetDataProvider instance to fetch expenses data
        dataProvider.fetchExpensesGroupedByCategory()

        // Now you can access the expenses data from dataProvider
        let data = dataProvider.expensesData

        var entries: [SimpleEntry] = []

        for widgetData in data {
            let date = Date()
            
            let category = widgetData.category
            let topThreeExpenses = widgetData.topThreeExpenses

            let widgetExpenseData = WidgetsData(category: category, topThreeExpenses: topThreeExpenses)
            let entry = SimpleEntry(date: date, expensesData: [widgetExpenseData])
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

//struct SimpleEntry: TimelineEntry {
//    let date: Date
//}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let expensesData: [WidgetsData]
}

//struct TestingWidgetsEntryView : View {
//    var entry: Provider.Entry
//
//    var body: some View {
//        Text(entry.date, style: .time)
//    }
//}

struct ExpensesWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        // Display the fetched expenses data here
        List(entry.expensesData) { categoryData in
            Text(categoryData.category)
            ForEach(categoryData.topThreeExpenses, id: \.name) { expense in
                Text("\(expense.name): $\(expense.amount)")
            }
        }
    }
}

//struct TestingWidgets: Widget {
//    let kind: String = "TestingWidgets"
//
//    var body: some WidgetConfiguration {
//        StaticConfiguration(kind: kind, provider: Provider()) { entry in
//            TestingWidgetsEntryView(entry: entry)
//        }
//        .configurationDisplayName("My Widget")
//        .description("This is an example widget.")
//    }
//}

struct ExpensesWidget: Widget {
    let kind: String = "ExpensesWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ExpensesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
