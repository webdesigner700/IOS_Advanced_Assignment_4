//
//  ExchangeRates.swift
//  IOS_Advanced_Assignment_4
//
//  Created by Grace Rufina Solibun on 26/10/2023.
//

import Foundation
import Combine

class ExchangeRatesViewModel: ObservableObject {
    @Published var exchangeRates: ExchangeRatesResponse?

    func fetchExchangeRates() {
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=b1344cef01a490fd0b9562873c917841") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ExchangeRatesResponse.self, decoder: JSONDecoder())
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: &$exchangeRates)
    }
}
