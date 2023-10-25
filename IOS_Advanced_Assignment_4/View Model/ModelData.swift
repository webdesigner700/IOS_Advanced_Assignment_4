//
//  ModelData.swift
//  IOS_Advanced_Assignment_4
//
//  Created by vinay bayyapunedi on 25/10/23.
//

import Foundation

final class ModelData: ObservableObject {
    
    @Published var selectedTheme: AppTheme = .light
    
    enum AppTheme: String, CaseIterable {
        case light = "Light"
        case dark = "Dark"
    }
    
    func setSelectedTheme() {
        
        // Try and retreive the raw value of the saved theme from UserDefaults.
        if let savedThemeRawValue = UserDefaults.standard.string(forKey: "SelectedTheme"),
           // if the savedThemeRawValue matches one of the enum cases from "AppTheme", "savedTheme" will set to the corresponding enum case.
            let savedTheme = AppTheme(rawValue: savedThemeRawValue) {
            // If savedTheme is successfully created, there was a previously selected theme saved in UserDefaults. In this case, the "selectedTheme" published property is set to the loaded theme.
            self.selectedTheme = savedTheme
        }
        else {
            // If no theme was previously saved in UserDefaults, or if the savedTheme does not match any AppTheme enum values, the theme is set to the default light theme.
            self.selectedTheme = .light
        }
    }
}
