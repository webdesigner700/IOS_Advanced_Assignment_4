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
                            .foregroundColor(.white)
                        Text("Dark Theme")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGray"), Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                }
                .frame(width: 160)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                
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
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color("LightYellow"), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                     .cornerRadius(15)
                     .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        )
                }
                .frame(width: 160)
                .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 10)
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
