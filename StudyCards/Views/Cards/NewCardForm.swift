//
//  NewCardForm.swift
//  StudyCards
//
//  Created by Matthew Manion on 12/20/21.
//

import SwiftUI

struct NewCardForm: View {
  @State var cardText: String = ""
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var cardListViewModel: CardListViewModel

  var body: some View {
    VStack(alignment: .center, spacing: 30) {
      VStack(alignment: .leading, spacing: 10) {
        Text("cardText")
          .foregroundColor(.gray)
        TextField("Enter the text", text: $cardText)
          .textFieldStyle(RoundedBorderTextFieldStyle())
      }
      Button(action: addCard) {
        Text("Add New Card")
          .foregroundColor(.blue)
      }
      Spacer()
    }
    .padding(EdgeInsets(top: 80, leading: 40, bottom: 0, trailing: 40))
  }
    
    private func addCard() {
        let card = Card( cardText: cardText)
        cardListViewModel.add(card)
        presentationMode.wrappedValue.dismiss()
    }

}

struct NewCardForm_Previews: PreviewProvider {
  static var previews: some View {
      NewCardForm(cardListViewModel: CardListViewModel())
  }
}


