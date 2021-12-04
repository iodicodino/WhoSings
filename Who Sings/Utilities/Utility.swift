//
//  Utility.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 04/12/21.
//

import Foundation

class Utility {
    
    static var artists: [Artist] = []
    
    static func getRandomLineFromLyrics(_ lyrics: String) -> String {
        
        let lineArray = lyrics.components(separatedBy: "\n")
        let randomLine = lineArray.randomElement()!
        
        return randomLine
    }
}

extension Collection {
    func choose(_ n: Int) -> ArraySlice<Element> { shuffled().prefix(n) }
}
