//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Dmitry Reshetnik on 17.02.2021.
//

import SwiftUI

class EmojiMemoryGame {
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        var emoji = ["👻","🎃","😈","💀","🧛🏻‍♂️","🦇","🧛🏻‍♂️","🕸","🕷"]
        emoji.shuffle()
        
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)) { pairIndex in
            emoji[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards.shuffled()
    }
    
    // MARK: - Intents
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
