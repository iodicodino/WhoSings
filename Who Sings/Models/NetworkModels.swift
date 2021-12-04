//
//  NetworkModels.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 02/12/21.
//

import Foundation
import UIKit


struct Track: Decodable {
    
    var track_id: Int
    var track_name: String
    var artist_id: Int
    var artist_name: String
    
    enum CodingKeys: String, CodingKey {
        case track_id = "track_id"
        case track_name = "track_name"
        case artist_id = "artist_id"
        case artist_name = "artist_name"
    }
}

struct Artist: Decodable {
    var artist_id: Int
    var artist_name: String
    
    enum CodingKeys: String, CodingKey {
        case artist_id = "artist_id"
        case artist_name = "artist_name"
    }
}

struct Option {
    var button: UIButton
    var label: UILabel
    var isRight: Bool
}
