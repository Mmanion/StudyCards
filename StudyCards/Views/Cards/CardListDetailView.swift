//
//  CardListDetailView.swift
//  StudyCards
//
//  Created by Matthew Manion on 1/5/22.
//

import SwiftUI

struct CardListDetailView: View {
    
 //   @ObservedObject var cardListDetailViewModel = CardListDetailViewModel()
    
    let cardVM: CardViewModel
    
    var body: some View {
        Text("\(cardVM.card.cardText)")
    }
}

struct CardListDetailView_Previews: PreviewProvider {
    @State static var cardVM = CardViewModel(card: testData[0])

    static var previews: some View {
        // fix CardListDetailView preview bug
        CardListDetailView(cardVM: cardVM)
    }
}
