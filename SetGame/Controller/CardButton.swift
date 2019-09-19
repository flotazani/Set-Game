//
//  CardButton.swift
//  SetGame
//
//  Created by Andrei Konovalov on 7/5/19.
//  Copyright © 2019 Andrei Konovalov. All rights reserved.
//
import UIKit
import Foundation
class CardButton: CardButtonLayout{
    
    let colors:[Card.Color : UIColor] = [.blue : #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), .yellow : #colorLiteral(red: 0.9712772965, green: 0.7638249397, blue: 0.2458150387, alpha: 1), .pirple :#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)]
    let symbols:[Card.Shape : String] =  [.circle : "●", .triangle : "▲",.square : "■"]
    let alphas: [Card.Fill : CGFloat] = [.solid : 1, .empty : 0.40, .stripe: 0.15]
    let Strokewidths:[Card.Fill : CGFloat] = [.solid : -8,.empty : 8, .stripe : -8]
    
    var verticalSizeClass: UIUserInterfaceSizeClass{
        return UIScreen.main.traitCollection.verticalSizeClass
    }
   
    var card: Card?{
        didSet{
            self.selectedState = .unselected
            updateButton()
        }
    }
    
    private func setAttributedString(card:Card) -> NSAttributedString{
        let symbol = symbols[card.shape]
        let separator = verticalSizeClass == .regular ? "\n" : " "
        let symbolString = symbol?.join(input: Int(card.num.description)!, with: separator)
        let attributes:[NSAttributedString.Key: Any] = [
            .strokeColor : colors[card.color] as Any,
            .strokeWidth : Strokewidths[card.fill] as Any,
            .foregroundColor : colors[card.color]?.withAlphaComponent(alphas[card.fill]!) as Any
        ]
        return NSAttributedString(string: symbolString ?? "х" , attributes: attributes)
    }
    
    private func updateButton(){
        if let  card = card{
            self.setAttributedTitle(setAttributedString(card: card), for: .normal)
            self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.isEnabled = true
        } else {
            self.setAttributedTitle(nil, for: .normal)
            self.setTitle(nil, for: .normal)
            self.backgroundColor = Layout.buttonBackgroundUnselected
            self.borderColor = Layout.borderColorUnselected
            self.isEnabled = false
        }
    }

    enum SelectionState{
        case unselected, selected, selectedMatched
        }
    var selectedState: SelectionState = .unselected {
        didSet{
            switch selectedState{
            case .unselected:
               // print("unselected ")
                borderColor = Layout.borderColorUnselected
                borderWidth = Layout.borderWidthUnselected
            case .selected: //print("selected ")
                borderColor = Layout.borderColorSelected
                borderWidth = Layout.borderWidthSelected
            case .selectedMatched:
                // print("selectedMatched")
                 self.setTitle("2", for: .normal)
            }
        }
    }

    private func configureA () {
        titleLabel?.numberOfLines = 0
        self.borderColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.borderWidth = 2.0
        self.borderCornerRad = 10
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        configureA()
    }
    
    required init?(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)
       configureA()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.verticalSizeClass == .compact {
            updateButton()
        }else if traitCollection.verticalSizeClass == .regular{
            updateButton()
        }
    }
}

extension String {
    func join(input: Int , with separator: String) ->String{
        guard input > 1 else {return self}
        var array = [String]()
        for _ in 0..<input{
            array += [self]
        }
        return array.joined(separator: separator)
    }
}
