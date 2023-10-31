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
    
    func addExpense(expense: Expense) {
        
        let Expense = Expense(context: viewContext)
        
        Expense.category = Expense.category
        
        do {
            try viewContext.save()
            
            Expenses.insert(Expense)
        }
        catch {
            
            fatalError("could not add the expense to the CoreData stack \(error.localizedDescription)")
        }
    }
}
