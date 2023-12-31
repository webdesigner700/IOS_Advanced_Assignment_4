//
//  ContentView.swift
//  IOS_Advanced_Assignment_4
//
//  Created by vinay bayyapunedi on 25/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        
        TabView() {
            
            HomeView()
                .tabItem {
                    Image(systemName: "house.circle")
                    Text("Home")
                }
            
            CurrencyExchangeView()
                .tabItem {
                    Image(systemName: "dollarsign.circle")
                    Text("Currency Exchange")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "lock.circle")
                    Text("Preferences")
                }
        }
        .modifier(ThemeModifier(selectedTheme: modelData.selectedTheme))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
