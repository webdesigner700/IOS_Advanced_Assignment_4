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
                    Text("\(currencyCode): \(exchangeRate, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("Exchange Rates", displayMode: .inline)
            .onAppear {
                print("View appeared, calling fetchExchangeRates()")
                viewModel.fetchExchangeRates()
            }
        }
    }
}

//struct CurrencyExchangeView_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrencyExchangeView()
//    }
//}
