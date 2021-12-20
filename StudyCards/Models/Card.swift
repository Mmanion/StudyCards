//
//  Card.swift
//  StudyCards
//
//  Created by Matthew Manion on 12/20/21.
//

import Foundation

struct Card: Identifiable {
  var id: String = UUID().uuidString
  var question: String
  var answer: String
  var successful: Bool = true
  var userId: String?
}

#if DEBUG
let testData = (1...10).map { i in
  Card(question: "Question #\(i)", answer: "Answer #\(i)")
}
#endif
