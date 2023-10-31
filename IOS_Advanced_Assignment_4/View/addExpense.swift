//
//  addExpense.swift
//  IOS_Advanced_Assignment_4
//
//  Created by vinay bayyapunedi on 31/10/23.
//

import SwiftUI

struct addExpense: View {
    
    @EnvironmentObject var modelData: ModelData
    
    @State private var id: UUID = UUID() // Initialize with a new random UUID
    @State private var expenseName: String = ""
    @State private var expenseAmount: String = ""
    @State private var category: String = ""
    @State private var timestamp: Date = Date()
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    let model = Inexpensify()
    
    var body: some View {
        
        VStack(spacing: 8) {
            
            TextField("Expense Name", text: $expenseName)
            TextField("Expense Amount", text: $expenseAmount)
            
            Button(action: {
                
                if let amount = Int(expenseAmount) {
                    
                    classifyText()
                    
//                    let id = UUID()
                    let transaction = Transaction(id: UUID(), name: expenseName, amount: amount, category: category, timestamp: Date())
                    
                    modelData.addExpense(transaction: transaction)
                    
                    alertMessage = "Expense added successfully!"
                    showAlert = true
                }
                else {
                    
                    alertMessage = "Please enter a valid amount."
                    showAlert = true
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
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Info"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
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

//struct addExpense_Previews: PreviewProvider {
//    static var previews: some View {
//        addExpense()
//            .environmentObject(ModelData())
//    }
//}
