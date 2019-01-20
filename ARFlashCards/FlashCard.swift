//
//  FlashCard.swift
//  ARFlashCards
//
//  Created by Zack Schreur on 1/19/19.
//  Copyright © 2019 Zack Schreur. All rights reserved.
//

import Foundation
import ARKit

class FlashCard {
    var id: String // special notecard symbol
    var name: String // name of card to store in database
    var additionalText: String
    
    init(id: String, name: String, additionalText: String?) {
        self.id = id
        self.name = name
        if (additionalText == nil) {
            self.additionalText = "Enter additional notes here"
        } else {
            self.additionalText = additionalText!
        }
    }
    
}
