//
//  CardListViewModel.swift
//  StudyCards
//
//  Created by Matthew Manion on 12/20/21.
//

import Foundation
import Combine

class CardListViewModel: ObservableObject {
    
    init() {
        cardRepository.$cards.map { cards in
            cards.map(CardViewModel.init)
        }
        .assign(to: \.cardViewModels, on: self)
        .store(in: &cancellables)
    }
    
    @Published var cardRepository = CardRepository()
    
    @Published var cardViewModels: [CardViewModel] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    func add(_ card: Card) {
        cardRepository.add(card)
    }
    
    func remove(_ card: Card) {
        cardRepository.remove(card)
    }
    
    // Not sure why it is "Index - 1" instead of just Index, should find that out.
    func delete(at offsets: IndexSet) {
        for index in offsets {
            cardViewModels.remove(at: index - 1)
            
            let deleteArrayItem = cardViewModels[index - 1].card
            remove(deleteArrayItem)
        }
    }
    
}
