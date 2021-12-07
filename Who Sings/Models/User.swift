//
//  User.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 02/12/21.
//

import Foundation

class User : Codable {
    
    init() {
        
    }
    
    var name: String?
    
    var scoreList: [Score] = []
    
    // MARK: - Encoding and Decoding
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case scoreList = "scoreList"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        scoreList = try values.decode([Score].self, forKey: .scoreList)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(scoreList, forKey: .scoreList)
    }
}

extension User {
    
    var bestScore: Score? {
        // Take best and most recent score
        if let max = scoreList.max(by: {$0.points > $1.points}) {
            let maxScores = scoreList.filter({$0.points == max.points})
            return maxScores.max(by: {$0.date > $1.date})
        }
        
        return nil
    }
    
}
