//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Dmitry Reshetnik on 17.02.2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        var emoji = ["👻","🎃","😈","💀","🧛🏻‍♂️","🦇","🕸","🕷"]
        emoji.shuffle()
        
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)) { pairIndex in
            emoji[pairIndex]
        }
    }
    
    // MARK: - Themes
    
    var themes: Set<Theme> = [
        Theme(name: "helloween", emoji: ["👻","🎃","😈","💀","🧛🏻‍♂️","🦇","🕸","🕷"], numberOfCards: 8, color: .orange),
        Theme(name: "animals", emoji: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐵"], numberOfCards: 9, color: .green),
        Theme(name: "sports", emoji: ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉","🎱"], numberOfCards: nil, color: .blue),
        Theme(name: "faces", emoji: ["😁","😊","😅","😆","😂","😎","🤪","🤓","🥳"], numberOfCards: 6, color: .yellow),
        Theme(name: "fruits", emoji: ["🍏","🍐","🍊","🍋","🍌","🍉","🍓","🍑","🥭"], numberOfCards: 7, color: .purple),
        Theme(name: "flowers", emoji: ["💐","🌷","🌹","🥀","🌺","🌸","🌼","🌻","🍀"], numberOfCards: nil, color: .pink)
    ]
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intents
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
