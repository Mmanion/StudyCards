//
//  CardView.swift
//  StudyCards
//
//  Created by Matthew Manion on 12/20/21.
//

import SwiftUI

struct CardView: View {
  var card: Card
  @State var showContent: Bool = false
  @State var viewState = CGSize.zero
  @State var showAlert = false

  var body: some View {
    ZStack(alignment: .center) {
      backView.opacity(showContent ? 1 : 0)
      frontView.opacity(showContent ? 0 : 1)
    }
    .frame(width: 250, height: 400)
    .background(Color.orange)
    .cornerRadius(20)
    .shadow(color: Color(.blue).opacity(0.3), radius: 5, x: 10, y: 10)
    .rotation3DEffect(.degrees(showContent ? 180.0 : 0.0), axis: (x: 0, y: -1, z: 0))
    .offset(x: viewState.width, y: viewState.height)
    .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
    .onTapGesture {
      withAnimation {
        showContent.toggle()
      }
    }
    .gesture(
      DragGesture()
        .onChanged { value in
          viewState = value.translation
        }
      .onEnded { value in
        if value.location.y < value.startLocation.y - 40.0 {
          self.showAlert.toggle()
        }
        viewState = .zero
      }
    )
      .alert(isPresented: $showAlert) {
        Alert(
          title: Text("Remove Card"),
          message: Text("Are you sure you want to remove this card?"),
          primaryButton: .destructive(Text("Remove")) {
          },
          secondaryButton: .cancel()
        )
      }
  }

  var frontView: some View {
    VStack(alignment: .center) {
      Spacer()
      Text(card.question)
        .foregroundColor(.white)
        .font(.system(size: 20))
        .fontWeight(.bold)
        .multilineTextAlignment(.center)
        .padding(20.0)
      Spacer()
    }
  }

  var backView: some View {
    VStack(alignment: .center) {
      Spacer()
      Text(card.answer)
        .foregroundColor(.white)
        .font(.body)
        .padding(20.0)
        .multilineTextAlignment(.center)
        .animation(.easeInOut)
      Spacer()
    }
    .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    let card = testData[0]
    return CardView(card: card)
  }
}
