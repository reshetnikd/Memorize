//
//  MemoryGame.swift
//  Memorize
//
//  Created by Dmitry Reshetnik on 17.02.2021.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isInvolvedInMismatch: Bool = false
        var content: CardContent
    }
    
    private(set) var cards: Array<Card>
    private(set) var theme: Theme
    private(set) var score: Int = 0
    private var timeWhenCardWasChosen: Date = Date()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, theme: Theme, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
        cards.shuffle()
        self.theme = theme
    }
    
    mutating func choose(_ card: Card) {
        print("card chosen: \(card)")
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2 * max(10 - Int(timeWhenCardWasChosen.distance(to: Date())), 1)
                } else {
                    if cards[chosenIndex].isInvolvedInMismatch && cards[potentialMatchIndex].isInvolvedInMismatch {
                        score -= 2 * max(10 - Int(timeWhenCardWasChosen.distance(to: Date())), 1)
                    } else if cards[chosenIndex].isInvolvedInMismatch || cards[potentialMatchIndex].isInvolvedInMismatch {
                        score -= 1 * max(10 - Int(timeWhenCardWasChosen.distance(to: Date())), 1)
                    }
                    cards[chosenIndex].isInvolvedInMismatch = true
                    cards[potentialMatchIndex].isInvolvedInMismatch = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = chosenIndex
            }
            timeWhenCardWasChosen = Date()
        }
    }
}
