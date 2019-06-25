//
//  Card.swift
//  concentration
//
//  Created by najmeh nasiriyani on 2019-06-18.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import Foundation
struct  Card {
    var isFaceUp=false
    var isMatched=false
    var identifier:Int
    static var uniqueIdentifier=0
    
    static func getUniqueIdentifier() -> Int{
        uniqueIdentifier += 1
        return uniqueIdentifier
    }
    
    init() {
        
        self.identifier = Card.getUniqueIdentifier()
    }
}
