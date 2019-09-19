//
//  ViewController.swift
//  SetGame
//
//  Created by Andrei Konovalov on 6/20/19.
//  Copyright © 2019 Andrei Konovalov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var NewGame: CardButtonLayout!
    @IBOutlet weak var DealMoreCards: CardButtonLayout!
    @IBOutlet var Hint: CardButtonLayout!
    @IBOutlet var DeckLable: UILabel!
    @IBOutlet var Buttons: [CardButton]!
    @IBOutlet weak var ScoreLable: UILabel!
    var score:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameEngine = Game()
        updateView()
    }
    // инициализурется вся модель, так же все cardbuttons получают значения карт или nil
    var gameEngine: Game!
    
    var selectedButtons:[CardButton]!{
       return Buttons.filter({$0.selectedState == .selected || $0.selectedState == .selectedMatched})
    }
    //проверка сколько карт выбрано если 3 и они сет, то Buttons.cards.selectedstate меняется
    var IfSet: Bool{
        let cardsSelected = selectedButtons.filter { $0.card != nil } .map { $0.card! }
        if cardsSelected.count == 3 && gameEngine.ifSet(cardsToCheck: cardsSelected) == true{
            selectedButtons.forEach {$0.selectedState = .selectedMatched}
            return true
        }
        return false
    }
    // В том случае если пользователь собрал сет удаляются карты из CardsOnScreen,
    //SelectedButtons.Cards обнуляются вызывается GetCardFromDeck обновляется счетчик
    private func updateView(){
       // все карты которые надо обновить имеют состояние selectedMatched
        Buttons.indices.forEach { (index) in
            if index < gameEngine.cardsOnTable.count{
                Buttons[index].card = gameEngine.cardsOnTable[index]
            } else{
                Buttons[index].card = nil
            }
        }
        Hint.isEnabled = true
        Hint.borderColor = CardButton.Layout.hintButtonTextColorEnabled
        Hint.setTitleColor(CardButton.Layout.hintButtonTextColorEnabled, for: .normal)
        selectedButtons.forEach{$0.card = nil}
        ScoreLable.text = "Score: \(gameEngine.score)"
        DeckLable.text = "Deck: \(gameEngine.deckCount)"
    }

    @IBAction func touchCard(_ sender: CardButton)  {
        if sender.selectedState == .selected{
            sender.selectedState = .unselected
            gameEngine.chooseCard(at: Buttons.firstIndex(of: sender)!)
        }else{
            sender.selectedState = .selected
            gameEngine.chooseCard(at: Buttons.firstIndex(of: sender)!)
            if IfSet || selectedButtons.count == 3{
                updateView()// перерисовать все кнопки с значениями взятыми из модели
                Hint.isEnabled = true
                _lastHint = 0
            }
        }
        
    }
 
    @IBAction func DealMoreCards(_ sender: Any) {
        let freeSlotsCount = Buttons.count - gameEngine.cardsOnTable.count
        if freeSlotsCount >= 3{
            if  (gameEngine.cardsOnTable.count + 3) <= Buttons.count {
                gameEngine.deal3()
                updateView()
            }
             if freeSlotsCount == 3{
                DealMoreCards.isHidden = true
            }
        }
    }
    
    @IBAction func NewGame(_ sender: Any) {
        gameEngine = Game()
        _lastHint = 0
        updateView()
        DealMoreCards.isHidden = false
    }
    
    private weak var timer: Timer?
    private var _lastHint = 0
    
    @IBAction func hint(_ sender: Any) {
        timer?.invalidate()
        let hints = gameEngine.hint()
        if  hints.count > 0  && _lastHint < hints.count{
            hints[_lastHint].forEach { (idx) in
                Buttons[idx].backgroundColor = CardButton.Layout.cardHintColor
            }
            timer = Timer.scheduledTimer(withTimeInterval: 0.5,repeats: false)
            { [weak self] time in
            hints[(self?._lastHint)!].forEach { (idx) in
                self?.Buttons[idx].borderColor  = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            }
                if self!._lastHint < hints.count {self?._lastHint += 1}
            self?.updateView()
            }
        }else {
            Hint.isEnabled = false
            Hint.borderColor = CardButton.Layout.hintButtonTextColorUnabled
            Hint.setTitleColor(CardButton.Layout.hintButtonTextColorUnabled, for: .normal)
        }
    }
}


