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
                withAnimation(.easeInOut) {
                    viewModel.restartGame()
                }
            }
            Grid(viewModel.cards) { card in
                CardView(card: card)
                    .onTapGesture {
                        withAnimation(.linear) {
                            viewModel.choose(card: card)
                        }
                    }
                    .padding(5)
            }
            .padding()
            .foregroundColor(viewModel.color)
            Text("Score: \(viewModel.gameScore)")
        }
    }
}

struct CardView: View {
    @State private var animatedBonusRemaining: Double = 0
    
    var card: MemoryGame<String>.Card
    
    // MARK: - Drawing Constants
    
    private let fontScaleFactor: CGFloat = 0.7
    
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Group {
                        if card.isConsumingBonusTime {
                            Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                                .onAppear {
                                    startBonusTimeAnimation()
                                }
                        } else {
                            Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                        }
                    }
                    .padding(5)
                    .opacity(0.4)
                    Text(card.content)
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(AnyTransition.scale)
                .font(Font.system(size: min(geometry.size.width, geometry.size.height) * fontScaleFactor))
            }
        }
    }
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let theme = Theme(name: "Helloween", emoji: ["👻","🎃","😈","💀","🧛🏻‍♂️","🦇","🕸","🕷"], numberOfCards: 8, color: UIColor.RGB(red: 253/255, green: 141/255, blue: 14/255, alpha: 1.0))
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame(usingTheme: theme))
    }
}
