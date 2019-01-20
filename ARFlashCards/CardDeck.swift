//
//  CardDeck.swift
//  ARFlashCards
//
//  Created by Zack Schreur on 1/19/19.
//  Copyright © 2019 Zack Schreur. All rights reserved.
//

import Foundation

class CardDeck {
    var flashCards = [String: FlashCard]()
    
    func addCard(name: String, flashCard: FlashCard) {
        flashCards[name] = flashCard
    }
    
    func getCard(name: String) -> FlashCard? {
        return flashCards[name]
    }
    
}
