//
//  Score.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 06/12/21.
//

import Foundation

class Score: Decodable, Encodable {
    
    init(points: Int, date: Date) {
        self.points = points
        self.date = date
    }
    
    var points: Int!
    var date: Date!
    
    
    // MARK: - Encoding and decoding
    
    enum CodingKeys: String, CodingKey {
        case points = "points"
        case date = "date"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        points = try values.decode(Int.self, forKey: .points)
        date = try values.decode(Date.self, forKey: .date)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(points, forKey: .points)
        try container.encode(date, forKey: .date)
    }
}

extension Score {
    var pointsString: String {
        return String(points) + "pt"
    }
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter.string(from: date)
    }
}
