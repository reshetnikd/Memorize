//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Dmitry Reshetnik on 17.02.2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let usedTheme = themes.randomElement()!
        var emoji = usedTheme.emoji
        emoji.shuffle()
        
        return MemoryGame<String>(numberOfPairsOfCards: usedTheme.numberOfCards, theme: usedTheme) { pairIndex in
            emoji[pairIndex]
        }
    }
    
    // MARK: - Themes
    
    private static var themes: Set<Theme> = [
        Theme(name: "Helloween", emoji: ["👻","🎃","😈","💀","🧛🏻‍♂️","🦇","🕸","🕷"], numberOfCards: 8, color: .orange),
        Theme(name: "Sports", emoji: ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉"], numberOfCards: 8, color: .blue),
        Theme(name: "Animals", emoji: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐵","🦁"], numberOfCards: 10, color: .green),
        Theme(name: "Faces", emoji: ["😁","😊","😅","😆","😂","😎","🤪","🤓","🥳","😋"], numberOfCards: 10, color: .yellow),
        Theme(name: "Fruits", emoji: ["🍏","🍐","🍊","🍋","🍌","🍉","🍓","🍑","🥭","🍒"], numberOfCards: 10, color: .purple),
        Theme(name: "Flowers", emoji: ["💐","🌷","🌹","🥀","🌺","🌸","🌼","🌻"], numberOfCards: 8, color: .pink)
    ]
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var chosenTheme: Theme {
        model.theme
    }
    
    var gameScore: Int {
        model.score
    }
    
    // MARK: - Intents
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func restartGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
