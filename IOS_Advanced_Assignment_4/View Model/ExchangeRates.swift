//
//  ExchangeRates.swift
//  IOS_Advanced_Assignment_4
//
//  Created by Grace Rufina Solibun on 26/10/2023.
//

import Foundation
import Combine

class ExchangeRates: ObservableObject {
    @Published var exchangeRates: ExchangeRatesResponse

    init() {
        // Initialize exchangeRates with a default value or an empty ExchangeRatesResponse
        self.exchangeRates = ExchangeRatesResponse(success: false, timestamp: 0, base: "", date: "", rates: [:])
    }

    func fetchExchangeRates() {
        print("func fetchExchangeRates() called!")
                
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=b1344cef01a490fd0b9562873c917841&base=AUD") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ExchangeRatesResponse.self, decoder: JSONDecoder())
            .replaceError(with: ExchangeRatesResponse(success: false, timestamp: 0, base: "", date: "", rates: [:]))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Data fetching completed successfully")
                case .failure(let error):
                    print("Data fetching failed with error: \(error)")
                }
            }, receiveValue: { [weak self] data in
                self?.exchangeRates = data
                print("Received data: \(data)")
            })
    }
}
