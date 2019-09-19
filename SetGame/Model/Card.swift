//
//  Card.swift
//  SetGame
//
//  Created by Andrei Konovalov on 6/28/19.
//  Copyright © 2019 Andrei Konovalov. All rights reserved.
//

import Foundation
struct Card:Hashable,Equatable,CustomStringConvertible{
    var description: String{return "color: \(color), shape: \(shape), num: \(num), shading: \(fill)"}
    
    var isMatched = false
    var isSelected = false
    let shape:Shape
    let color:Color
    let num:Num
    let fill:Fill
    private static var identifierFactory = 0
    
    func hash(into hasher: inout Hasher) {
        Card.identifierFactory+=1
        hasher.combine(Card.identifierFactory)
    }
    
//    static func ==(lhs: Card, rhs: Card) -> Bool {
//        return lhs.hashValue == rhs.hashValue
//    }
    
    var matrixWithInts:[Int]{
        return [shape.rawValue,num.rawValue,color.rawValue,fill.rawValue]
    }
    
    init(shape:Int,color:Int,num:Int,fill:Int){
        self.shape = Shape(rawValue: shape)!
        self.color = Color(rawValue: color)!
        self.num = Num(rawValue: num)!
        self.fill = Fill(rawValue: fill)!
        
    }
    
    enum Shape:Int,CustomStringConvertible{
        case square = 1
        case triangle
        case circle
        var description: String{
        switch self {
        case .square: return "square"
        case .triangle: return "trianlge"
        case .circle: return "circle"
            }
            
        }
        
    }
    
    enum Color:Int,CustomStringConvertible{
        case yellow = 1
        case blue
        case pirple
        var description: String{
            switch self {
            case .yellow: return "green"
            case .blue: return "blue"
            case .pirple: return "orange"
            }
        }
    }
    
    enum Num:Int,CustomStringConvertible{
        case one = 1
        case two
        case three
        var description: String{
            switch self {
            case .one: return String(self.rawValue)
            case .two: return String(self.rawValue)
            case .three: return String(self.rawValue)
            }
        }
        
    }
            
        
    enum Fill:Int,CustomStringConvertible{
        case solid = 1
        case stripe
        case empty
        var description: String{
            switch self {
            case .solid: return "solid"
            case .stripe: return "strape"
            case .empty: return "shading"
            }
        }
    }

}



