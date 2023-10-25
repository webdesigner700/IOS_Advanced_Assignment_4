//
//  SettingsView.swift
//  IOS_Advanced_Assignment_4
//
//  Created by vinay bayyapunedi on 25/10/23.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        
        VStack {
            
            Text("App Theme")
                .font(.headline)
                .padding(.bottom, 10)
            
            // A horizontal stack containing buttons to select between a Dark and Light theme.
            HStack(spacing: 20) {
                
                // This Button sets the dark theme by setting a specific value to the UserDefaults key "SelectedTheme".
                Button(action: {
                    UserDefaults.standard.set("Dark", forKey: "SelectedTheme")
                    modelData.setSelectedTheme()
                }) {
                    HStack {
                        Image(systemName: "moon.fill")
                            .foregroundColor(.black)
                        Text("Dark Theme")
                            .foregroundColor(.black)
                    }
                }
                .frame(width: 160)
                
                Button(action: {
                    UserDefaults.standard.set("Light", forKey: "SelectedTheme")
                    modelData.setSelectedTheme()
                }) {
                    HStack {
                        Image(systemName: "sun.max.fill")
                            .foregroundColor(.black)
                        Text("Light Theme")
                            .foregroundColor(.black)
                    }
                }
                .frame(width: 160)
            } // This bracket is for the horizontal stack containing the app theme buttons
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ModelData())
    }
}
