//
//  ContentView.swift
//  StudyCards
//
//  Created by Matthew Manion on 12/20/21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    var body: some View {
        TabView {
            CardListView()
                .tabItem {
                    Image(systemName: "house")
             //       Text("Home")
                }
            Text("Settings")
                .tabItem {
                    Image(systemName: "magnifyingglass")
             //       Text("Search")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
