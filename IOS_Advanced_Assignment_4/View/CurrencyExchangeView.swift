//
//  CurrencyExchangeView.swift
//  IOS_Advanced_Assignment_4
//
//  Created by vinay bayyapunedi on 25/10/23.
//

import SwiftUI
import FlagKit

func countryCodeForCurrencyCode(_ currencyCode: String) -> String? {
    print("func countryCodeForCurrencyCode() called!")
    
    let currencyCodeToCountryCodeMapping = [
        "USD": "US", 
        "BGN": "BG",
        "HUF": "HU",
        "HKD": "HK",
        "IDR": "ID",
        "ILS": "IL",
        "INR": "IN",
        "ISK": "IS",
        "JPY": "JP",
        "KRW": "KR",
        "MXN": "MX",
        "MYR": "MY",
        "BRL": "BR",
        "CAD": "CA",
        "CHF": "CH",
        "CNY": "CN",
        "CZK": "CZ",
        "DKK": "DK",
        "EUR": "EU",
        "GBP": "GB",
        "NOK": "NO",
        "NZD": "NZ",
        "PHP": "PH",
        "PLN": "PL",
        "RON": "RO",
        "SEK": "SE",
        "SGD": "SG",
        "THB": "TH",
        "TRY": "TR",
        "ZAR": "ZA"
    ]
    
    if let countryCode = currencyCodeToCountryCodeMapping[currencyCode] {
        print("Currency Code: \(currencyCode), Country Code: \(countryCode)")
        return countryCode
    } else {
        print("No mapping found for Currency Code: \(currencyCode)")
        return nil
    }
}

struct CurrencyExchangeView: View {
    @ObservedObject var viewModel = ExchangeRates()

    var body: some View {
        NavigationView {
            VStack {
                
//                Text("Currency Exchange")
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .multilineTextAlignment(.leading)
                
                List {
                    ForEach(viewModel.exchangeRates.rates.sorted(by: <), id: \.key) { currencyCode, exchangeRate in
                        HStack {
                            Spacer().frame(width: 5)
                            
                            if let countryCode = countryCodeForCurrencyCode(currencyCode),
                               let flag = Flag(countryCode: countryCode) {
                                Image(uiImage: flag.originalImage)
                                    .resizable()
                                    .frame(width: 40, height: 30)
                            }
                            
                            Spacer().frame(width: 15)
                            
                            Text(currencyCode)
                            
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
                            
                            Spacer().frame(width: 10)
                            
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
                            
                        }
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading:
                HStack {
                    Spacer().frame(width: 7)
                
                Text("Currency Exchange")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 50)
                    .padding(.bottom, 50)
                }
            )
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
