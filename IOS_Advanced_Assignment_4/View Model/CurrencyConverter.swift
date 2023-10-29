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
//        print("CurrencyConverter init called with currencyCode: \(currencyCode) and exchangeRate: \(exchangeRate)")
        self.currencyCode = currencyCode
        self.exchangeRate = exchangeRate
    }

    func convertAmount(inputAmount: String) {
        print("func convertAmount() called!")

        // Remove leading and trailing whitespace
        let trimmedInput = inputAmount.trimmingCharacters(in: .whitespacesAndNewlines)

        if let amount = Double(trimmedInput) {
            print("Input Amount: \(trimmedInput)")
            print("Successfully converted to Double: \(amount)")
            print("Exchange Rate: \(exchangeRate)")
            convertedAmount = amount * exchangeRate
            print("Converted Amount: \(convertedAmount)")
        } else {
            print("Failed to convert input to Double. Invalid input detected.")
        }
    }
}
