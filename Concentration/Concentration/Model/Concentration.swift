//
//  Concentration.swift
//  Concentration
//
//  Created by Lorenzo Baldassarri on 05.06.18.
//  Copyright © 2018 Lorenzo Baldassarri. All rights reserved.
//

import Foundation

class Concentration {
    
    // Does same as
    //var cards : Array<Card> = []
    //var cards = Array<Card>()
    var cards = [Card]()
    var indexOfOnlyFaceUpCard: Int?
    
    init(numberOfPairsOfCards : Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        print("Sorted cards: ")
        for card in cards {
            print(card.identifier)
        }
        
        // TODO: Shuffle the cards in the array
        shuffleCards()
        
        print("Shuffled cards: ")
        for card in cards {
            print(card.identifier)
        }
    }
    
    func chooseCard(at index : Int) -> String {
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOnlyFaceUpCard, matchIndex != index {
                
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOnlyFaceUpCard = nil
                
            } else {
                
                // none or 2 cards face up
                for flipOverIndex in cards.indices {
                    cards[flipOverIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOnlyFaceUpCard = index
                
            }
        }
        
        // check if game is over
        var matchedCounter = 0
        for card in cards {
            matchedCounter += card.isMatched ? 1 : 0
        }
        
        if cards.count == matchedCounter {
            return "won"
        } else {
            return "lost"
        }
        
    }
    
    // Shuffles all the cards in the cards array
    func shuffleCards() {
        var cardsShuffled = [Card]()
        var randomNumber: Int
        for _ in cards {
            randomNumber = Int(arc4random_uniform(UInt32(cards.count-1)))
            cardsShuffled.append(cards[randomNumber])
            cards.remove(at: randomNumber)
        }
        self.cards = cardsShuffled
    }
}
