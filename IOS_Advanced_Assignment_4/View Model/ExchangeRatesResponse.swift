//
//  ExchangeRatesResponse.swift
//  IOS_Advanced_Assignment_4
//
//  Created by Grace Rufina Solibun on 26/10/2023.
//

import Foundation

struct ExchangeRatesResponse: Codable {
    let amount: Double
    let base: String
    let date: String
    let rates: [String: Double]
}
