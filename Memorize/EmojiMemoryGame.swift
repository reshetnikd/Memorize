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
        let usedTheme = themes.randomElement()!
        var emoji = usedTheme.emoji
        emoji.shuffle()
        
        return MemoryGame<String>(numberOfPairsOfCards: usedTheme.numberOfCards != nil ? usedTheme.numberOfCards! : Int.random(in: 2...(emoji.count > 5 ? 5 : emoji.count)), theme: usedTheme) { pairIndex in
            emoji[pairIndex]
        }
    }
    
    // MARK: - Themes
    
    static var themes: Set<Theme> = [
        Theme(name: "Helloween", emoji: ["👻","🎃","😈","💀","🧛🏻‍♂️","🦇","🕸","🕷"], numberOfCards: 4, color: .orange),
        Theme(name: "Sports", emoji: ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉"], numberOfCards: 4, color: .blue),
        Theme(name: "Animals", emoji: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐵","🦁"], numberOfCards: 5, color: .green),
        Theme(name: "Faces", emoji: ["😁","😊","😅","😆","😂","😎","🤪","🤓","🥳","😋"], numberOfCards: 5, color: .yellow),
        Theme(name: "Fruits", emoji: ["🍏","🍐","🍊","🍋","🍌","🍉","🍓","🍑","🥭","🍒"], numberOfCards: nil, color: .purple),
        Theme(name: "Flowers", emoji: ["💐","🌷","🌹","🥀","🌺","🌸","🌼","🌻"], numberOfCards: nil, color: .pink)
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
