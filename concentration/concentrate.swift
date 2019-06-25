//
//  concentrate.swift
//  concentration
//
//  Created by najmeh nasiriyani on 2019-06-18.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import Foundation
class Concentrate{
    var cards = [Card]()
    
    var oneAndOnlyOneCardFaceUp : Int?
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards{
            let card=Card()
            cards += [card, card]
        }
        //shuffle cards
        for i in 0..<cards.count{
            let j = Int(arc4random_uniform(UInt32(cards.count - 1)))
            if(i != j){
                cards.swapAt(i, j)
            }
        }
    }
    func chooseCard(at index: Int){
        if !cards[index].isMatched{
            if let matchIndex = oneAndOnlyOneCardFaceUp , matchIndex != index{
                if cards[index].identifier == cards[matchIndex].identifier
                {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                }
                cards[index].isFaceUp = true
                oneAndOnlyOneCardFaceUp = nil
            }else {
                for indexFaceDown in cards.indices{
                    cards[indexFaceDown].isFaceUp = false
                }
                cards[index].isFaceUp = true
                oneAndOnlyOneCardFaceUp = index
                
            }
            
        }
    }
}
