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
                .frame(width: 20, height: 20)
                .onTapGesture {
                    self.cardVM.card.active.toggle()
                }
            Text("\(cardVM.card.cardText)").padding()
        }
    }
}

struct CardCell_Previews: PreviewProvider {
    static var previews: some View {
        CardCell(cardVM: CardViewModel(card: Card(cardText: "This is a test")))
    }
}
