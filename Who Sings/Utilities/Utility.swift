//
//  Utility.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 04/12/21.
//

import Foundation

class Utility {
    
    static var artists: [Artist] = []
    
    static func filteredArtists(number: Int, withoutId id: Int) -> [Artist] {
        let filteredArtists = artists.filter({$0.artist_id != id})
        return Array(filteredArtists.choose(number))
    }
    
    static var currentScore: Int = 0
    
    private static var APIMessageIndicator: String = "*******"
    
    static func getRandomLineFromLyrics(_ lyrics: String) -> String? {
        
        var lineArray = lyrics.components(separatedBy: "\n")
        
        // Remove message string from array, such as ******* This Lyrics is NOT for Commercial use *******
        lineArray = lineArray.filter { string in
            if string.hasPrefix(APIMessageIndicator), string.hasSuffix(APIMessageIndicator) {
                return false
            }
            
            return true
        }
        
        let characters = "abcdefghijklmnopqrstuvwxyz"
        var set = CharacterSet()
        set.insert(charactersIn: characters)
        
        // Filter empty lines. Lines should have at least one allowed character
        lineArray = lineArray.filter({($0.isEmpty == false) && ($0.rangeOfCharacter(from: set) != nil)})
        let randomLine = lineArray.randomElement()
        
        return randomLine
    }
}

extension Collection {
    func choose(_ n: Int) -> ArraySlice<Element> { shuffled().prefix(n) }
}
