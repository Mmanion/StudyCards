//
//  CardListDetailView.swift
//  StudyCards
//
//  Created by Matthew Manion on 1/5/22.
//

import SwiftUI

struct CardListDetailView: View {
    
    let card: Card
    
    var body: some View {
        Text("\(card.cardText)")
    }
}

struct CardListDetailView_Previews: PreviewProvider {
    @State static var cardTest: Card = testData[0]

    static var previews: some View {
        // fix CardListDetailView preview bug
        CardListDetailView(card: cardTest)
    }
}
