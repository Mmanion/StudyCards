//
//  CardListViewModel.swift
//  StudyCards
//
//  Created by Matthew Manion on 12/20/21.
//

import Foundation
import Combine

class CardListViewModel: ObservableObject {
    
    @Published var cardRepository = CardRepository()
    
    func add(_ card: Card) {
        cardRepository.add(card)
    }
    
}
