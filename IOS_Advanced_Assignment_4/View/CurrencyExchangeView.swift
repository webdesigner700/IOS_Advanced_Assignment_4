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
                        Spacer().frame(width: 15)
                        
                        Text("\(currencyCode)")
                        
                        Spacer().frame(width: 20)
                        
                        VStack {
                            Text("Current rate:")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .foregroundColor(.gray)
                                .italic()
                                .padding(.top, 30)
                            Text("\(exchangeRate, specifier: "%.2f")")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.bottom, 30)
                        }
                        
                        Spacer().frame(width: 15)
                        
                        Divider()
                            .frame(height: 50)
                            .background(Color.gray)
                        
                        Spacer().frame(width: 20)
                        
//                            Image(systemName: "chevron.right")
//                                .padding(.trailing, 10)
//                                .foregroundColor(.black)
                        
                        Image(systemName: "chevron.right")
                            .padding(.trailing, 10)
                            .foregroundColor(.black)
                            .overlay(
                                NavigationLink(
                                    destination: MoneyExchangeView(currencyCode: currencyCode, exchangeRate: exchangeRate),
                                    label: { EmptyView() }
                                )
                                .opacity(0)
                            )
                        
                        Spacer().frame(width: 1)
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


//struct CurrencyExchangeView_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrencyExchangeView()
//    }
//}
