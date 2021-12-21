//
//  CardRepository.swift
//  StudyCards
//
//  Created by Matthew Manion on 12/20/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class CardRepository: ObservableObject {
    
    var userId = ""
    
    private let authenticationService = AuthenticationService()
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let path: String = "cards"
    
    private let store = Firestore.firestore()
    
    @Published var cards: [Card] = []
    
    init() {
        authenticationService.$user
            .compactMap { user in
                user?.uid
            }
            .assign(to: \.userId, on: self)
            .store(in: &cancellables)
        
        authenticationService.$user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.get()
            }
            .store(in: &cancellables)
    }
    
    func get() {
        
        store.collection(path)
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                print("Error getting cards: \(error.localizedDescription)")
                return
            }
                
                
            self.cards = querySnapshot?.documents.compactMap { document in
                try? document.data(as: Card.self)
            } ?? []
        }
    }
    
    
    
    func add(_ card: Card) {
        do {
            var newCard = card
            newCard.userId = userId
            _ = try store.collection(path).addDocument(from: card)
        } catch {
            fatalError("Unable to add card: \(error.localizedDescription).")
        }
    }
    
    func update(_ card: Card) {
        guard let cardId = card.id else { return }
        
        do {
            try store.collection(path).document(cardId).setData(from: card)
        } catch {
            fatalError("Unable to update card: \(error.localizedDescription)")
        }  
    }
    
    func remove(_ card: Card) {
        guard let cardId = card.id else { return }
        
        store.collection(path).document(cardId).delete { error in
            if let error = error {
                print("Unable to remove card: \(error.localizedDescription)")
            }
        }
    }
    
}
