//
//  CardsDeck.swift
//  SetGame
//
//  Created by Andrei Konovalov on 7/2/19.
//  Copyright © 2019 Andrei Konovalov. All rights reserved.
//

import Foundation
struct CardDeck:CustomStringConvertible {
    var description: String{
        return "carddeck \(cards)"
    }
    
    var cards: [Card] = []
   
    mutating func draw(amount:amountOfCardsToAdd = .three)->[Card]?{
        if cards.count < amount.rawValue {return nil}
        var returnaArray = [Card]()
        for _ in 1...amount.rawValue{
            returnaArray.append(cards.remove(at: cards.count.arc4random))
        }
        return returnaArray
    }
    
    
    enum amountOfCardsToAdd:Int{
        case three = 3
        case twelve = 12
    }
    init(){
        for color in 1...3{
            for num in 1...3{
                for fill in 1...3{
                    for shape in 1...3{
                        let card = Card(shape: shape,color: color,num: num,fill: fill)
                        cards.append(card)
                    }
                }
            }
        }
       // cards.removeSubrange(0...65)
    }
    
    

}
extension Int {
    var arc4random: Int{
        switch self {
        case 1...Int.max: return Int(arc4random_uniform(UInt32((self))))
        case -Int.max...0: return Int(arc4random_uniform(UInt32((self))))
        default:
            return 0
        }
    }
}
