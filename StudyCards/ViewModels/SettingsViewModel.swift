//
//  SettingsViewModel.swift
//  StudyCards
//
//  Created by Matthew Manion on 12/30/21.
//

import Foundation
import Combine
import SwiftUI

class SettingsViewModel: ObservableObject {
    
    @AppStorage("minuteInterval") var minuteInterval: Double = 15

    init() {
        
    }
    
}
