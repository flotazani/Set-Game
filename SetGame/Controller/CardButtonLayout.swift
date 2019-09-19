//
//  ButtonCard.swift
//  SetGame
//
//  Created by Andrei Konovalov on 7/12/19.
//  Copyright © 2019 Andrei Konovalov. All rights reserved.
//

import UIKit

@IBDesignable class CardButtonLayout: UIButton{

    struct Layout{
        static let borderWidthUnselected: CGFloat = 2.0
        static let borderColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        static let borderColorUnselected = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        static let buttonBackgroundUnselected = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
        static let borderWidthSelected: CGFloat = 2.0
        static let borderColorSelected = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        static let borderCornerRad: CGFloat = 10.0
        
        
        static let cardHintColor = #colorLiteral(red: 1, green: 0.5212053061, blue: 1, alpha: 0.2777838908)
        
        static let hintButtonTextColorUnabled =  #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        static let hintButtonTextColorEnabled =  #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        
    }
    
   
    @IBInspectable var borderColor: UIColor = Layout.borderColor{
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = Layout.borderWidthUnselected{
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderCornerRad: CGFloat = Layout.borderCornerRad{
        didSet{
            layer.cornerRadius = borderCornerRad
        }
    }
    @IBInspectable var buttonBackground: UIColor = Layout.buttonBackgroundUnselected{
        didSet{
            layer.backgroundColor = buttonBackground.cgColor
        }
    }
    
    required init?(coder ADecoder: NSCoder) {
        super.init(coder: ADecoder)
        configure()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    private func configure(){
        layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        layer.cornerRadius = borderCornerRad
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        clipsToBounds = true
    }
}
