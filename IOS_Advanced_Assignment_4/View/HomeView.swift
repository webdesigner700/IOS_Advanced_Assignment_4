//
//  HomeView.swift
//  IOS_Advanced_Assignment_4
//
//  Created by vinay bayyapunedi on 25/10/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var userInput: String = ""
    @State private var category: String = ""
    
    @EnvironmentObject var modelData: ModelData

    @FetchRequest(entity: Expense.entity(), sortDescriptors: []) var expenses: FetchedResults<Expense>
    
    let model = Inexpensify()
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading, spacing: 20) {
                // Budget Overview Section
                Text("Budget Overview")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                        
                // Display budget details here
                
                // We can display the three boxes of information here
                        
                // Recent Expenses Section
                Text("Recent Expenses")
                    .font(.title)
                    .fontWeight(.bold)

                List(expenses, id: \.self) { expense in
                    Text("ID: \(expense.id), Category: \(expense.category ?? "Unknown")")
                }
                
                // Add Expense Button
                NavigationLink(destination: Expenses()) {
                    Text("Add Expense")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                        
                Spacer()
            }
            .padding()
        }
    }

    func classifyText() {
        do {
            let prediction = try model.prediction(text: userInput)
            category = prediction.label
        } catch {
            print("Error classifying text: \(error)")
            category = "Error"
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ModelData())
    }
}
