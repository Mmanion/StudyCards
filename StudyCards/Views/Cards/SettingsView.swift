//
//  SettingsView.swift
//  StudyCards
//
//  Created by Matthew Manion on 12/30/21.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var settingsViewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView {
                    
            VStack {
                Text("How often Widget shows new Cards")
                Slider(value: settingsViewModel.$minuteInterval, in: 0...60, step: 1)
                Text("Every \(settingsViewModel.minuteInterval) minutes")
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
