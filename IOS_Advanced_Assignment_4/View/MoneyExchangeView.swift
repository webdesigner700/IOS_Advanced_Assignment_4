//
//  MoneyExchangeView.swift
//  IOS_Advanced_Assignment_4
//
//  Created by Grace Rufina Solibun on 27/10/2023.
//

import SwiftUI

struct MoneyExchangeView: View {
    let currencyCode: String
    let exchangeRate: Double
    @ObservedObject var currencyConverterViewModel: CurrencyConverter

    @State private var inputAmount: String = ""
    @State private var convertedAmount: Double = 0.0

    var body: some View {
        VStack {
            Text("\(currencyCode) with exchange rate \(exchangeRate)")

            TextField("Enter Amount", text: $inputAmount)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Convert") {
                currencyConverterViewModel.convertAmount()
            }

            Text("Converted \(currencyCode) Amount: \(convertedAmount, specifier: "%.2f")")
        }
    }
}

//struct MoneyExchangeView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoneyExchangeView()
//    }
//}
