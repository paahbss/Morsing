//
//  TranslateManager.swift
//  Morsing
//
//  Created by Paloma Bispo on 09/02/19.
//  Copyright © 2019 Paloma Bispo. All rights reserved.
//

import UIKit

class TranslateManager: NSObject {
    
    static let shared = TranslateManager()
    var characters: [Item] = []
    
    override init() {
        if let letters = Item.letters(), let numbers = Item.numbers(){
            characters.append(contentsOf: letters)
            characters.append(contentsOf: numbers)
        }
    }
    
    func translate(textToMorse text: String) -> (success: Bool, morse: String?, invalidChar: Character?){
        var morseResult = ""
        for  letter in text{
            if letter == " " {
                morseResult += "/"
            }else{
                let item = characters.filter {$0.text == String(letter).capitalized}
                if (item.count < 1){
                    return (false, nil, letter)
                }else{
                    let morse = item[0].morse
                    for (index, _) in morse.enumerated(){
                        morseResult +=  morse[index] == 1 ? "-" : "."
                    }
                }
            }
        }
        return (true, morseResult, nil)
    }
    
    func translate(morseToText morse: [Int]) -> (succes: Bool, character: String?){
        let itens: [Item] = TranslateManager.shared.characters.filter { (item) -> Bool in
            return morse == item.morse
        }
        if !itens.isEmpty{
            if let letter = itens.first{
                return (true, letter.text)
            }
            return (false, nil)
        }else{
            return (false, nil)
        }
    }
}
