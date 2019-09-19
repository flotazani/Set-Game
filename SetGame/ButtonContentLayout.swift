//
//  ButtonContentLayout.swift
//  SetGame
//
//  Created by Andrei Konovalov on 7/6/19.
//  Copyright © 2019 Andrei Konovalov. All rights reserved.
//

import Foundation
import UIKit


struct ViewModel {
    let colors: [Card.Color : CGColor] = [.orange : #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1).cgColor, .green : #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1).cgColor, .blue : #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1).cgColor]
    let shapes: [Card.Shape : String] = [ .circle: "●", .triangle: "▲", .square: "■" ]
    let alpha: [Card.fill : Double] = [.solid : 1.0, .empty : 0.40, .stripe : 0.15]
    let strokeWidth: [Card.fill : Double] = [.solid: -5, .empty: 5, .stripe: -5]
}

struct  LayoutModel {
    let borderwidth: UI = 1
    let borderColor: CGColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    
    let borderwidthIfSelected: CGFloat = 3
    let borderColorIfSelected: CGColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1).cgColor
    
    let borderwidthIfMatched: CGFloat = 4
    let borderColorIfMatched: CGColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor
    
    
    
}
