//
//  Utility.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 04/12/21.
//

import Foundation

class Utility {
    
    static var artists: [Artist] = []
    
    static var currentScore: Int = 0
    
    static func getRandomLineFromLyrics(_ lyrics: String) -> String {
        
        var lineArray = lyrics.components(separatedBy: "\n")
        
        let characters = "abcdefghijklmnopqrstuvwxyz"
        var set = CharacterSet()
        set.insert(charactersIn: characters)
        
        /// Filter array not empty and with at leas one allowed character
        lineArray = lineArray.filter({($0.isEmpty == false) && ($0.rangeOfCharacter(from: set) != nil)})
        let randomLine = lineArray.randomElement()!
        
        return randomLine
    }
}

extension Collection {
    func choose(_ n: Int) -> ArraySlice<Element> { shuffled().prefix(n) }
}
