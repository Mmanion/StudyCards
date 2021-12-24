//
//  WidgetCards.swift
//  WidgetCards
//
//  Created by Matthew Manion on 12/22/21.
//

import WidgetKit
import SwiftUI
import Intents
import Firebase

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        // Fetching data from Firebase for every 15 min
        let date = Date()
        
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 5, to: date)!
        
        fetchFromDB { studyCard in
            let card = SimpleEntry(date: date, configuration: configuration, studyCardData: studyCard)
            
            let timeline = Timeline(entries: [card], policy: .after(nextUpdate))
            
            completion(timeline)
        }
    }
    
    // Firebase Data...
    func fetchFromDB(completion: @escaping(StudyCardWidgetModel)->()){
        
 //        You can fetch the current user Data Like...
        guard let _ = Auth.auth().currentUser else{
            completion(StudyCardWidgetModel(question: "Fail to Auth user", answer: ""))
            return
        }
        
//        let db = Firestore.firestore().collection("cards").document("zvZuhqhhJHkw4Hz767wL")
//
//        db.getDocument { snap, err in
//            guard let doc = snap?.data() else {
//                completion(StudyCardWidgetModel(question: "", answer: "Get Document Error"))
//                return
//            }
//            let question = doc["question"] as? String ?? ""
//            let answer = doc["answer"] as? String ?? ""
//
//            completion(StudyCardWidgetModel(question: question, answer: answer))
//        }
        
        let db = Firestore.firestore().collection("cards")
        var studyCards: [StudyCardWidgetModel] = []
        
        db.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                studyCards = []
                for document in querySnapshot!.documents {
                    let data = document.data()
                    print("\(document.documentID) => \(document.data())")
                    
                    let question = data["question"] as? String ?? ""
                    let answer = data["answer"] as? String ?? ""
                    let newStudyCard = StudyCardWidgetModel(question: question, answer: answer)
                    studyCards.append(newStudyCard)
                }
            }
            let randomIndex = Int.random(in:0...studyCards.count-1)
            
            let randomSelected = studyCards[randomIndex]
            
//            let question = doc["question"] as? String ?? ""
//            let answer = doc["answer"] as? String ?? ""
            
            completion(StudyCardWidgetModel(question: randomSelected.question, answer: randomSelected.answer))
        }
        
        
        
        
        
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    var studyCardData: StudyCardWidgetModel?
}

struct WidgetCardsEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack{
            
            if let card = entry.studyCardData {
                    Text("\(card.question)").padding()
                    
              //      Text("\(card.answer)")
                
            } else {
                //loading view...
                Text("Fetching Data...")
            }
        }
    }
}

// StudyCard Model...

struct StudyCardWidgetModel: Identifiable {
    var id: String?
    var question: String
    var answer: String
    var successful: Bool = true
    var userId: String?
}

@main
struct WidgetCards: Widget {
    
    init() {
        FirebaseApp.configure()
        do {
            try Auth.auth().useUserAccessGroup("\(teamId).com.sourselabs.StudyCards")
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    let kind: String = "WidgetCards"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WidgetCardsEntryView(entry: entry)
        }
        .supportedFamilies([.systemLarge, .systemMedium, .systemSmall])
        
        .configurationDisplayName("Study Cards Widget")
        .description("Study Card")
    }
}

struct WidgetCards_Previews: PreviewProvider {
    static var previews: some View {
        WidgetCardsEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
