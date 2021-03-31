//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Dmitry Reshetnik on 17.02.2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    
    var theme: Theme
    
    private static func createMemoryGame(usingTheme theme: Theme) -> MemoryGame<String> {
        var emoji = theme.emoji
        emoji.shuffle()

        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfCards, theme: theme) { pairIndex in
            emoji[pairIndex]
        }
    }
    
    init(usingTheme theme: Theme) {
        self.theme = theme
        self.model = EmojiMemoryGame.createMemoryGame(usingTheme: theme)
    }
    
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
        model = EmojiMemoryGame.createMemoryGame(usingTheme: theme)
    }
}
