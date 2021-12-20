//
//  StudyCardsApp.swift
//  StudyCards
//
//  Created by Matthew Manion on 12/20/21.
//

import SwiftUI
import Firebase

@main
struct StudyCardsApp: App {
    init() {
        FirebaseApp.configure()
 //       Auth.auth().signInAnonymously()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
