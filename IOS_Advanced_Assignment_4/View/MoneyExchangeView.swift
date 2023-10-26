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

    var body: some View {
        Text("\(currencyCode) with exchange rate \(exchangeRate)")
    }
}

//struct MoneyExchangeView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoneyExchangeView()
//    }
//}
