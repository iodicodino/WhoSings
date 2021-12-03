//
//  NetworkUtility.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 02/12/21.
//

import Foundation
import Alamofire

class NetworkUtility {
    
    // MARK: - Base urls
    
    private static let baseURL: String = "https://api.musixmatch.com/ws/"
    private static let APIVersion: String = "1.1"
    private static let endpoint: String = baseURL + APIVersion + "/"
    
    private static let apikey: String = "f8c86a1b7c8b921a4a8252815ca62e03"
    
    
    // MARK: - Completions
    
    typealias TrackCompletion = ((Track?) -> Void)
    typealias TracksCompletions = (([Track]?) -> Void)
    
    
    // MARK: - Public functions
    
    static func requestSongFromPage(_ page: Int, completion: TrackCompletion?) {
        let url = endpoint + "chart.tracks.get?apikey=\(apikey)&page=\(String(page))&page_size=1&f_has_lyrics=1"
        
        let request = AF.request(url)
        
        request.responseJSON {
            response in
            
            let statusCode = NetworkParser.parseNetworkStatusCode(from: response.value)
            
            if statusCode != 200 {
                //Error
                print("*** NETWORK ERROR: \(statusCode ?? 0) - Something went wrong")
            } else {
                let track = NetworkParser.parseTrackList(response.value).first
                completion?(track)
            }
        }
    }
}
