//
//  MoneyExchangeView.swift
//  IOS_Advanced_Assignment_4
//
//  Created by Grace Rufina Solibun on 27/10/2023.
//

import SwiftUI

struct MoneyExchangeView: View {
    let currencyCode: String
    let exchangeRate: Double
    @ObservedObject var currencyConverterViewModel: CurrencyConverter

    @State private var inputAmount: String = ""
    @State private var convertedAmount: Double = 0.0
    
    init(currencyCode: String, exchangeRate: Double) {
//        print("MoneyExchangeView init called with currencyCode: \(currencyCode) and exchangeRate: \(exchangeRate)")
        self.currencyCode = currencyCode
        self.exchangeRate = exchangeRate
        self.currencyConverterViewModel = CurrencyConverter(currencyCode: currencyCode, exchangeRate: exchangeRate)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Convert to \(currencyCode)\nwith exchange rate\n\(exchangeRate)")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 10)
                .padding(.bottom, 30)

            
//            TextField("Enter Amount", text: $inputAmount)
//                .keyboardType(.decimalPad)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.bottom, 25)
//                .padding(.trailing, 50)
            
            
            //Make TextField appear to full width
            HStack {
                TextField("Enter Amount", text: $inputAmount)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 25)
                
                Spacer()
            }
                

//            Button("Convert") {
//                print("Button Pressed")
//                print("Input Amount (Before Binding): \(inputAmount)")
//                currencyConverterViewModel.convertAmount(inputAmount: inputAmount) // Pass inputAmount as a parameter
//                print("Input Amount (After Binding): \(inputAmount)")
//                print("Converted Amount: \(currencyConverterViewModel.convertedAmount)")
//            }
            
            
            Button(action: {
                print("Button Pressed")
                print("Input Amount (Before Binding): \(inputAmount)")
                currencyConverterViewModel.convertAmount(inputAmount: inputAmount) // Pass inputAmount as a parameter
                print("Input Amount (After Binding): \(inputAmount)")
                print("Converted Amount: \(currencyConverterViewModel.convertedAmount)")
            }) {
                Text("Convert")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.black)
                    .cornerRadius(5)
                    .padding(.bottom, 10)
            }
            
            
//            Text("Converted \(currencyCode) Amount: \(convertedAmount, specifier: "%.2f")")
            
            Text("Converted \(currencyCode) Amount:")
            
            Text("\(currencyConverterViewModel.convertedAmount, specifier: "%.2f")")
                .font(.system(size: 24))
                .bold()
                .padding(.bottom, 90)
        }
        .padding(30)
    }
}

//struct MoneyExchangeView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoneyExchangeView()
//    }
//}
