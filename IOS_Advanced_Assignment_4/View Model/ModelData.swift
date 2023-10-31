//
//  ModelData.swift
//  IOS_Advanced_Assignment_4
//
//  Created by vinay bayyapunedi on 25/10/23.
//

import Foundation
import CoreData

final class ModelData: ObservableObject {
    
    @Published var selectedTheme: AppTheme = .light
    
    private var viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    
    @Published var Expenses = Set<Expense>()
    
    enum AppTheme: String, CaseIterable {
        case light = "Light"
        case dark = "Dark"
    }
    
    func setSelectedTheme() {
        
        // Try and retreive the raw value of the saved theme from UserDefaults.
        if let savedThemeRawValue = UserDefaults.standard.string(forKey: "SelectedTheme"),
           // if the savedThemeRawValue matches one of the enum cases from "AppTheme", "savedTheme" will set to the corresponding enum case.
            let savedTheme = AppTheme(rawValue: savedThemeRawValue) {
            // If savedTheme is successfully created, there was a previously selected theme saved in UserDefaults. In this case, the "selectedTheme" published property is set to the loaded theme.
            self.selectedTheme = savedTheme
        }
        else {
            // If no theme was previously saved in UserDefaults, or if the savedTheme does not match any AppTheme enum values, the theme is set to the default light theme.
            self.selectedTheme = .light
        }
    }
    
    func addExpense(transaction: Transaction) {
        
        let Expense = Expense(context: viewContext)
        
        Expense.id = Int32(transaction.id)
        Expense.name = transaction.name
        Expense.amount = Int32(transaction.amount)
        Expense.category = transaction.category
        Expense.addTime = transaction.addTime
        
        do {
            try viewContext.save()
            
            Expenses.insert(Expense)
        }
        catch {
            
            fatalError("could not add the expense to the CoreData stack \(error.localizedDescription)")
        }
    }
    
    func deleteExpense(transaction: Transaction) {
    
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Expense")

        // Assuming "id" is the unique attribute for Transaction in CoreData
        fetchRequest.predicate = NSPredicate(format: "id == %d", transaction.id)

        do {
            // Fetch the Transaction objects from CoreData matching the criteria
            let fetchedResults = try viewContext.fetch(fetchRequest) as? [NSManagedObject]

            // Check if a transaction was fetched
            if let expenseToDelete = fetchedResults?.first {
                // Delete the fetched Transaction object from the CoreData context
                viewContext.delete(expenseToDelete)
                
                // Try and save changes to the managedObjectContext
                try viewContext.save()
            }
        } catch {
            // Print an error if the deletion was not successful
            fatalError("Failed to delete transaction: \(error)")
        }
    }
    
    func deleteAllExpenses() {
        // Create a fetch request for the "Expense" entity
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Expense")

        // Create a batch delete request and execute it
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try viewContext.execute(batchDeleteRequest)
            try viewContext.save()
            
            // Clear the Expenses set as well
            Expenses.removeAll()
        } catch let error as NSError {
            print("Error deleting all expenses: \(error), \(error.userInfo)")
        }
    }
    
}
