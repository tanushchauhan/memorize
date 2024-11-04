//
//  ContentView.swift
//  memorize
//
//  Created by Tanush Chauhan on 11/4/24.
//

import SwiftUI

struct ContentView: View {
    @State var cardsTill: Int = 1
    let emojis = ["🤓", "🤔", "💡", "🤖", "🔥", "🍇"]
    var body: some View {
        VStack{
            Cards
            Spacer()
            CardAddingButtons
        }.padding()
    }
    
    var Cards: some View{
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]){
            ForEach(0..<cardsTill, id: \.self){ index in
                IndiCard(content:emojis[index])
                    .aspectRatio(1/1, contentMode: .fit)
            }.padding(5)
        }
        
    }
    
    var CardAddingButtons: some View {
        HStack{
            CardButtonAdjuster(by: 1, icon: "rectangle.stack.fill.badge.plus")
                .disabled(cardsTill > emojis.count-1)
            Spacer()
            CardButtonAdjuster(by: -1, icon: "rectangle.stack.fill.badge.minus")
                .disabled(cardsTill < 2)
        }
        .padding()
    }
    
    func CardButtonAdjuster(by offset: Int, icon: String) -> some View{
        Button(action: {
            cardsTill += offset
        }, label: {
            Image(systemName: icon)
                .imageScale(.large)
                .font(.title)
        })
    }
}


struct IndiCard: View{
    var content = ""
    @State var isFlipped: Bool = false
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            base.fill(Color.white).opacity(isFlipped ? 1 : 0)
            base.stroke(lineWidth: 12)
            Text(content).opacity(isFlipped ? 1 : 0)
                .font(.largeTitle)
            base.fill(Color.orange).opacity(isFlipped ? 0 : 1)
        }
        .foregroundStyle(.orange)
        .onTapGesture {
            isFlipped.toggle()
        }
    }
}


#Preview {
    ContentView()
}

