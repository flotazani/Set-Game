//
//  Game.swift
//  SetGame
//
//  Created by Andrei Konovalov on 6/28/19.
//  Copyright © 2019 Andrei Konovalov. All rights reserved.
//

import Foundation

struct Game{
    private(set) var score = 0
    private(set) var numberSets = 0
    
    private(set) var cardsOnTable = [Card?]()
    private(set) var cardsSelected = [Card]()
    private(set) var cardsTryMatched = [Card]()
    private(set) var cardsRemoved = [Card]()
    
    private var deck = CardDeck()
    var deckCount: Int {return deck.cards.count}
    
    func ifSet(cardsToCheck: [Card?])->Bool?{
        guard cardsToCheck.count == 3 else {return nil}
        var SumMatrix = [Int](repeating: 0, count: 4)
        for card in cardsToCheck{
            if card == nil {return false}
            var matrix = card!.matrixWithInts
            matrix.indices.forEach({SumMatrix[$0]+=matrix[$0]})
        }
        return SumMatrix.reduce(true, {$0 && ($1 % 3 == 0)})
    }
    
    mutating func chooseCard(at index: Int) {
        if let cardChoosen = cardsOnTable[index]{
            if !cardsRemoved.contains(cardChoosen) && !cardsTryMatched.contains(cardChoosen){
                if cardsSelected.count == 2, !cardsSelected.contains(cardChoosen){
                    cardsSelected.inOut(element: cardChoosen)
                    cardsTryMatched = cardsSelected
                    cardsSelected.removeAll()
                    if ifSet(cardsToCheck: cardsTryMatched) == true {
                        replaceOrRemove3Cards()
                        score += Points.matchBonus
                    } else {
                        cardsTryMatched.removeAll()
                        score -= Points.missMatchPenalty
                    }
                } else if !cardsSelected.inOut(element: cardChoosen) {score -= Points.flipOverPenalty}
            }
        }else{print("Choosen index out of range")}
    }

    mutating func replaceOrRemove3Cards(){
        if let take3Cards = take3FromDeck() {
            cardsOnTable.replace(elements: cardsTryMatched , with: take3Cards)
        } else {
           /* cardsOnTable = */replaceWithNil( same: cardsTryMatched)
        }
        cardsRemoved += cardsTryMatched
        cardsTryMatched.removeAll()
    }
    
    mutating private func replaceWithNil( same elements: [Card?])/* -> [Card?]*/{
        //var changedArray = cardsOnTable
        for inindex in 0..<cardsOnTable.count{
            for index in 0..<elements.count{
                if let a = cardsOnTable[inindex]{
                    if a == elements[index]{
                        cardsOnTable[inindex] = nil
                    }
                }
            }
        }
      //  return changedArray
    }
    
     mutating func take3FromDeck() -> [Card]?{
       if let threeCards = deck.draw(amount: .three){return threeCards}
       else {return nil}
        
    }
    
    mutating func deal3() {
        if let deal3Cards =  take3FromDeck() {
            cardsOnTable += deal3Cards
        }
    }
    
    mutating func hint()->[[Int]]{
        var hints: [[Int]] {
            var hints = [[Int]]()
            if cardsOnTable.count > 2 {
                for i in 0..<cardsOnTable.count {
                    for j in (i+1)..<cardsOnTable.count {
                        for k in (j+1)..<cardsOnTable.count {
                            let cards = [cardsOnTable[i], cardsOnTable[j], cardsOnTable[k]]
                            if ifSet(cardsToCheck: cards)! {
                                hints.append([i,j,k])
                            }
                        }
                    }
                }
            }
            return hints
        }
        score -= Points.hintUsePenalty
        return hints
    }
    
    init() {
        cardsOnTable  = deck.draw(amount: .twelve) ?? []
    }
    //------------------ Constants -------------
    private struct Points {
        static let matchBonus = 7
        static let missMatchPenalty = 5
        static var hintUsePenalty = 3
        static var flipOverPenalty = 1
    }
}

extension Array where Element : Equatable {
    /// переключаем присутствие элемента в массиве:
    /// если нет - включаем, если есть - удаляем
    mutating func inOut(element: Element)->Bool{
        if let from = self.firstIndex(of:element)  {
            self.remove(at: from)
            return false
        } else {
            self.append(element)
            return true
        }
    }
    func containsOptional(_ element: Element?) -> Bool {
        guard element != nil else{return false}
        for i in self{
            if i == element {
                return true
            }
        }
        return false
    }
    mutating func remove(elements: [Element]){
        /// Удаляем массив элементов из массива
        self = self.filter { !elements.contains($0) }
    }
    
    mutating func replace(elements: [Element], with new: [Element] ){
        /// Заменяем элементы массива на новые
        guard elements.count == new.count else {return}
        for idx in 0..<new.count {
            if let indexMatched = self.firstIndex(of: elements[idx]){
                self [indexMatched ] = new[idx]
            }
        }
    }
    
    func indices(of elements: [Element]) ->[Int]{
        guard self.count >= elements.count, elements.count > 0 else {return []}
        /// Ищем индексы элементов elements у себя - self
        return elements.map{self.firstIndex(of: $0)}.compactMap{$0}
    }
}

