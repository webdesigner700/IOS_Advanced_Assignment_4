//
//  CurrencyConverter.swift
//  IOS_Advanced_Assignment_4
//
//  Created by Grace Rufina Solibun on 29/10/2023.
//

import Foundation
import SwiftUI

class CurrencyConverter: ObservableObject {
    @Published var inputAmount: String = ""
    @Published var convertedAmount: Double = 0.0
    let currencyCode: String
    let exchangeRate: Double

    init(currencyCode: String, exchangeRate: Double) {
        self.currencyCode = currencyCode
        self.exchangeRate = exchangeRate
    }

    func convertAmount() {
        print("func convertAmount() called!")
        if let amount = Double(inputAmount) {
            convertedAmount = amount * exchangeRate
            print("Amount: \(amount)")
            print("Exchange Rate: \(exchangeRate)")
            print("Converted Amount: \(convertedAmount)")
        }
    }
}
