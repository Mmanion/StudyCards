//
//  CardViewModel.swift
//  StudyCards
//
//  Created by Matthew Manion on 12/20/21.
//

import Foundation
import Combine

class CardViewModel: ObservableObject, Identifiable {
    
    private let cardRepository = CardRepository()
    @Published var card: Card
    
    private var cancellables: Set<AnyCancellable> = []
    
    var id = ""
    
    init(card: Card) {
        self.card = card
        
        $card
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
    
    func update(card: Card) {
        cardRepository.update(card)
    }
    
    func remove() {
        cardRepository.remove(card)
    }
    
    func toggleActive(card: Card) {
        if card.active == true {
            self.card.active = false
        } else {
            self.card.active = true
        }
        update(card: card)
    }
    
}
