//
//  Expenses.swift
//  IOS_Advanced_Assignment_4
//
//  Created by vinay bayyapunedi on 31/10/23.
//

import SwiftUI

struct Expenses: View {
    
    @EnvironmentObject var modelData: ModelData
       
    @FetchRequest(entity: Expense.entity(), sortDescriptors: []) var expenses: FetchedResults<Expense>
    
    var body: some View {
        
        List(expenses, id: \.self) { expense in
            Text("ID: \(expense.id), Category: \(expense.category ?? "Unknown")")
        }
    }
}

struct Expenses_Previews: PreviewProvider {
    static var previews: some View {
        Expenses()
            .environmentObject(ModelData())
    }
}
