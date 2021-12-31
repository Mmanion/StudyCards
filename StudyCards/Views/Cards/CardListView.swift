//
//  CardListView.swift
//  StudyCards
//
//  Created by Matthew Manion on 12/20/21.
//

import SwiftUI

struct CardListView: View {
  var cards: [Card] = []
  @State var showForm = false
    @State private var showSettings: Int? = 0
  @ObservedObject var cardListViewModel = CardListViewModel()

  var body: some View {
    NavigationView {
        List {
            ForEach(cardListViewModel.cardViewModels) { cardVM in
                CardCell(cardVM: cardVM)
            }
            .onDelete(perform: cardListViewModel.delete)
        }
        .sheet(isPresented: $showForm) {
            NewCardForm(cardListViewModel: CardListViewModel())
        }
      .navigationBarTitle("Study Cards")
        /// Find out the proper formatting for this navigationLink
        // find out what this comment about swift lint means and where it came from
        // swiftlint:disable multiple_closures_with_trailing_closure
      .navigationBarItems(leading: Button(action: { } ) {
          NavigationLink(destination: SettingsView(), label: {
              Image(systemName: "square")
                .font(.title)
          })
      })
        .navigationBarItems(trailing: Button(action: { showForm.toggle() }) {
          Image(systemName: "plus")
            .font(.title)
        })
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct CardListView_Previews: PreviewProvider {
  static var previews: some View {
      CardListView(cardListViewModel: CardListViewModel())
  }
}
