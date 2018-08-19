//
//  Card.swift
//  Concentration
//
//  Created by Lorenzo Baldassarri on 05.06.18.
//  Copyright © 2018 Lorenzo Baldassarri. All rights reserved.
//

import Foundation


// Struct:
// Has methods and variables just like a class
// Struct has no inheritance (child parent relation) -> simpler than classes
// Structs are value types Class is refrence type that means,
// structs get copyed classes have pointers and get copied when you pass them.
// structs get a free initializer with all vars that are in it
struct Card {
    
    // Doesn't need emoji since it is UI independent!!! identifier instead
    var isFaceUp = false
    var isMatched = false
    var identifier : Int
    
    static var idFactory = 0
    
    static func getUniqueID() -> Int {
        Card.idFactory += 1
        return Card.idFactory
    }
    
    // Custom initializer
    init() {
        self.identifier = Card.getUniqueID()
    }
}
