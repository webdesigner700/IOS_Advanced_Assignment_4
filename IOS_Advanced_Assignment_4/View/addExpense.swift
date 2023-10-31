//
//  addExpense.swift
//  IOS_Advanced_Assignment_4
//
//  Created by vinay bayyapunedi on 31/10/23.
//

import SwiftUI

struct addExpense: View {
    
    @EnvironmentObject var modelData: ModelData
    
    @State private var expenseName: String = ""
    @State private var expenseAmount: String = ""
    @State private var category: String = ""
    
    let model = Inexpensify()
    
    var body: some View {
        
        VStack(spacing: 8) {
            
            TextField("Expense Name", text: $expenseName)
            TextField("Expense Amount", text: $expenseAmount)
            
            Button(action: {
                
                if let amount = Int(expenseAmount) {
                    
                    let transaction = Transaction(name: expenseName, amount: amount, category: category)
                    
                    modelData.addExpense(transaction: transaction)
                    
                }
            }) {
                Text("Add Expense")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
        }
    }
    
    func classifyText() {
        do {
            let prediction = try model.prediction(text: expenseName)
            category = prediction.label
        } catch {
            print("Error classifying text: \(error)")
            category = "Error"
        }
    }
}

struct addExpense_Previews: PreviewProvider {
    static var previews: some View {
        addExpense()
            .environmentObject(ModelData())
    }
}
