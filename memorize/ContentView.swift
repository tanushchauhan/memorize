//
//  ContentView.swift
//  memorize
//
//  Created by Tanush Chauhan on 11/4/24.
//

import SwiftUI

enum themeItems: String{
    case animals, food, nature
}

let animals = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦇"]
let food = ["🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓",]
let nature = ["🌲", "🌳", "🌿", "🍀", "🍁", "🍄", "🌴", "🌲", "🌿", "🍀"]

// This function first doubles each emoji because the passed in array only contains all unique emojies. Then shuffels them and returns

func getEmojisPairRandomized(emojisArray: [String]) -> [String]{
    var arrayOfEmojis: [String] = []
    for index in 0..<emojisArray.count{
        for _ in 0...1{
            arrayOfEmojis.append(emojisArray[index])
        }
    }
    arrayOfEmojis.shuffle()
    return arrayOfEmojis
}



struct ContentView: View {
    @State var emojis: [String] = getEmojisPairRandomized(emojisArray: animals)
    var body: some View {
        VStack{
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView{
                giveCards()
            }
            Spacer()
            ThemeChoosingButtons
        }.padding()
    }
    
    var ThemeChoosingButtons: some View{
        HStack(spacing: 40) {
            ThemeButton(theme: .nature, symbol: "leaf.fill")
            ThemeButton(theme: .animals, symbol: "pawprint.fill")
            ThemeButton(theme: .food, symbol: "carrot.fill")
        }
    }
    
    
    func ThemeButton(theme: themeItems, symbol: String) -> some View{
            Button(action: {
                emojis = getEmojisPairRandomized(emojisArray: theme == .animals ? animals : theme == .food ? food : nature)
            }){
                VStack{
                    Image(systemName: symbol).font(.largeTitle)
                    Text(theme == .animals ? "Animals" : theme == .food ? "Food" : "Nature").font(.system(size: 20))
                }
            }
    }
    
    // Generating the cards in a grid
    
    func giveCards() -> some View{
        return LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()]){
            ForEach(0..<(emojis.count), id: \.self){ index in
                IndiCard(content:emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }.padding(5)
        }
    }
}

// individual card

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

