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
    
    private let path: String = "cards"
    
    private let store = Firestore.firestore()
    
    @Published var cards: [Card] = []
    
    init() {
        get()
    }
    
    func get() {
        
        store.collection(path)
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
            _ = try store.collection(path).addDocument(from: card)
        } catch {
            fatalError("Unable to add card: \(error.localizedDescription).")
        }
    }
    
}
