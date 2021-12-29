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
      VStack(alignment: .leading, spacing: 5) {
        Text("Create StudyCard")
        //  .foregroundColor(.black)
        TextEditor(text: $cardText)
              .cornerRadius(25)
              .frame(height: UIScreen.screenHeight / 3, alignment: .center)
              .cornerRadius(25)
              .border(Color.blue, width: 2)
              .lineSpacing(10)
              .autocapitalization(.sentences)
              .disableAutocorrection(true)
              .padding()
        //  .textFieldStyle(RoundedBorderTextFieldStyle())
      }
      Button(action: addCard) {
        Text("Submit")
              .frame(width: UIScreen.screenWidth / 3, height: 40)
              .padding(10)
              .font(.custom("Hiragino Sans", size: 14))
              .foregroundColor(.white)
              .background(RoundedRectangle(cornerRadius: 30))
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


