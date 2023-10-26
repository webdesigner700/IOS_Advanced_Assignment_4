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
    private var cancellables: Set<AnyCancellable> = [] // Declare cancellables

    init() {
        // Initialize exchangeRates with a default value or an empty ExchangeRatesResponse
        self.exchangeRates = ExchangeRatesResponse(success: false, timestamp: 0, base: "", date: "", rates: [:])
    }

    func fetchExchangeRates() {
        print("func fetchExchangeRates() called!")
        
        guard let url = URL(string: "https://api.frankfurter.app/latest?from=AUD") else {
            print("Invalid URL")
            return
        }
        
        print("Fetching data from URL: \(url)")

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
            }, receiveValue: { data in
                print("Received data: \(data)")
                // Print the raw data response for further analysis
            })
            .store(in: &cancellables) // Subscribe and store the subscription
    }
}
