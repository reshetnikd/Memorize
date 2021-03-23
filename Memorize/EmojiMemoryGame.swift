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
        var json: Data? {
            try? JSONEncoder().encode(usedTheme)
        }
        
        emoji.shuffle()
        print(json!.utf8!)
        
        return MemoryGame<String>(numberOfPairsOfCards: usedTheme.numberOfCards, theme: usedTheme) { pairIndex in
            emoji[pairIndex]
        }
    }
    
    // MARK: - Themes
    
    private static var themes: Set<Theme> = [
        Theme(name: "Helloween", emoji: ["👻","🎃","😈","💀","🧛🏻‍♂️","🦇","🕸","🕷"], numberOfCards: 8, color: UIColor.RGB(red: 253/255, green: 141/255, blue: 14/255, alpha: 1.0)),
        Theme(name: "Sports", emoji: ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉"], numberOfCards: 8, color: UIColor.RGB(red: 16/255, green: 107/255, blue: 255/255, alpha: 1.0)),
        Theme(name: "Animals", emoji: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐵","🦁"], numberOfCards: 10, color: UIColor.RGB(red: 48/255, green: 211/255, blue: 59/255, alpha: 1.0)),
        Theme(name: "Faces", emoji: ["😁","😊","😅","😆","😂","😎","🤪","🤓","🥳","😋"], numberOfCards: 10, color: UIColor.RGB(red: 254/255, green: 207/255, blue: 15/255, alpha: 1.0)),
        Theme(name: "Fruits", emoji: ["🍏","🍐","🍊","🍋","🍌","🍉","🍓","🍑","🥭","🍒"], numberOfCards: 10, color: UIColor.RGB(red: 175/255, green: 57/255, blue: 238/255, alpha: 1.0)),
        Theme(name: "Flowers", emoji: ["💐","🌷","🌹","🥀","🌺","🌸","🌼","🌻"], numberOfCards: 8, color: UIColor.RGB(red: 252/255, green: 26/255, blue: 77/255, alpha: 1.0))
    ]
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var chosenTheme: Theme {
        model.theme
    }
    
    var color: Color {
        model.theme.getColor()
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
