//
//  ClassificationView.swift
//  IOS_Advanced_Assignment_4
//
//  Created by Aryan Sinha on 31/10/23.
//

import SwiftUI

struct ClassificationView: View {
    @State private var userInput: String = ""
    @State private var category: String = ""

    let model = Inexpensify()

    var body: some View {
        VStack {
            Text("Testing the Classifier App")
                .font(.largeTitle)
                .padding()

            TextField("Enter a word", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Classify") {
                classifyText()
            }
            .font(.headline)
            .padding()

            Text("Category: \(category)")
                .font(.headline)
                .padding()
        }
    }

    func classifyText() {
        do {
            let prediction = try model.prediction(text: userInput)
            category = prediction.label
        } catch {
            print("Error classifying text: \(error)")
            category = "Error"
        }
    }
}
