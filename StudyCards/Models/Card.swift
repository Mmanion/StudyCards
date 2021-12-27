//
//  Card.swift
//  StudyCards
//
//  Created by Matthew Manion on 12/20/21.
//

import Foundation
import FirebaseFirestoreSwift

struct Card: Identifiable, Codable {
  @DocumentID var id: String?
  var cardText: String
  var active: Bool = true
  var userId: String?
}


#if DEBUG
let testData = (1...10).map { i in
  Card(cardText: "Text #\(i)")
}
#endif
