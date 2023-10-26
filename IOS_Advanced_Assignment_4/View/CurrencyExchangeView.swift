//
//  CurrencyExchangeView.swift
//  IOS_Advanced_Assignment_4
//
//  Created by vinay bayyapunedi on 25/10/23.
//

import SwiftUI

struct CurrencyExchangeView: View {
    @ObservedObject var viewModel = ExchangeRates()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.exchangeRates.rates.sorted(by: <), id: \.key) { currencyCode, exchangeRate in
                    HStack {
                        Text("\(currencyCode)")
                        Spacer()
                        VStack {
                            Text("Current rate:")
                            Text("\(exchangeRate, specifier: "%.2f")")
                        }
                    }
                }
            }
            .navigationBarTitle("Exchange Rates", displayMode: .inline)
            .onAppear {
                print("View appeared, calling fetchExchangeRates()")
                viewModel.fetchExchangeRates()
            }
            .onReceive(viewModel.$exchangeRates) { _ in
                // Update the UI on the main thread
                DispatchQueue.main.async {
                    // Force a view update by changing a @State variable
                    // This will trigger a refresh of the view
                }
            }
        }
    }
}

//struct CurrencyExchangeView_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrencyExchangeView()
//    }
//}
