//
//  CardCell.swift
//  StudyCards
//
//  Created by Matthew Manion on 12/27/21.
//

import SwiftUI

struct CardCell: View {
    @ObservedObject var cardVM: CardViewModel
    
    let cards = testData
    
    //var onCommit: (Card) -> (Void) = { _ in }
    
    var body: some View {
        HStack {
            Image(systemName: cardVM.card.active ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 30, height: 30)
                .onTapGesture {
                    // not the SwiftUI way of doing things, research further.
                    self.cardVM.card.active.toggle()
                    self.cardVM.toggleActive(card: cardVM.card)
                }
            Text("\(cardVM.card.cardText)").font(.custom("Hiragino Sans", size: 14)).padding()
        }
    }
}

struct CardCell_Previews: PreviewProvider {
    static var previews: some View {
        CardCell(cardVM: CardViewModel(card: Card(cardText: "This is a test")))
    }
}
