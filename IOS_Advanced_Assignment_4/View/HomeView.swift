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
                    
                    HStack {
                        Text(expense.name ?? "") // Use default value in case name is nil
                        Spacer()
                        Text("\(expense.amount)")
                        Spacer()
                        Text("\(expense.category ?? "Generic")")
                        
                        
                        Button(action: {
                            
                            let transaction = Transaction(id: expense.id, name: expense.name!, amount: expense.amount, category: expense.category!, addTime: expense.addTime!)
                            // Here you call your delete function
                            modelData.deleteExpense(transaction: transaction)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
                
                // Add Expense Button
                NavigationLink(destination: addExpense()) {
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ModelData())
    }
}
