//
//  SearchBarView.swift
//  IOS_Advanced_Assignment_4
//
//  Created by Grace Rufina Solibun on 30/10/2023.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(.horizontal)
            Button(action: {
                searchText = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .opacity(searchText.isEmpty ? 0 : 1)
            }
            .padding(.horizontal)
        }
    }
}

//struct SearchBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBarView()
//    }
//}
