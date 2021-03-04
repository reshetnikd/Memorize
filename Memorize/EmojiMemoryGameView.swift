//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Dmitry Reshetnik on 15.02.2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Button("New Game") {
                viewModel.restartGame()
            }
            Text(viewModel.chosenTheme.name)
            Grid(viewModel.cards) { card in
                CardView(card: card, color: viewModel.chosenTheme.color)
                    .onTapGesture {
                        viewModel.choose(card: card)
                    }
                    .padding(5)
            }
            .padding()
            .foregroundColor(viewModel.chosenTheme.color)
            Text("Score: \(viewModel.gameScore)")
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var color: Color
    
    // MARK: - Drawing Constants
    
    private let fontScaleFactor: CGFloat = 0.7
    
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
                        .padding(5)
                        .opacity(0.4)
                    Text(card.content)
                }
                .cardify(isFaceUp: card.isFaceUp, color: color)
                .font(Font.system(size: min(geometry.size.width, geometry.size.height) * fontScaleFactor))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
