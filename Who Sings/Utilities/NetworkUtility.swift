//
//  NetworkUtility.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 02/12/21.
//

import Foundation
import Alamofire

// MARK: - Completions

typealias EmptyCompletion = (() -> Void)
typealias TrackCompletion = ((Track?) -> Void)
typealias LyricsCompletion = ((String?) -> Void)
typealias TrackAndLineCompletion = ((Track, String) -> Void)
typealias ArtistsCompletion = (([Artist]?) -> Void)


class NetworkUtility {
    
    // MARK: - Base urls
    
    private static let baseURL: String = "https://api.musixmatch.com/ws/"
    private static let APIVersion: String = "1.1"
    private static let endpoint: String = baseURL + APIVersion + "/"
    
    private static let apikey: String = "f8c86a1b7c8b921a4a8252815ca62e03"
    
    // MARK: - Track
    
    static func requestSongFromRandomPage(completion: TrackCompletion?) {
        let randomNumber = Int.random(in: 1..<80)
        requestSongFromPage(randomNumber, completion: completion)
    }
    
    static func requestSongFromPage(_ page: Int, completion: TrackCompletion?) {
        let url = endpoint + "chart.tracks.get?page=\(String(page))&page_size=1&f_has_lyrics=1&apikey=\(apikey)"
        print("REQUEST FROM URL: \(url)")
        
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
    
    // MARK: - Lyrics
    
    static func requestLyrics(fromTrack track: Track, completion: LyricsCompletion?) {
        let url = endpoint + "track.lyrics.get?track_id=\(track.track_id)&apikey=\(apikey)"
        print("REQUEST FROM URL: \(url)")
        
        let request = AF.request(url)
        
        request.responseJSON {
            response in
            
            let statusCode = NetworkParser.parseNetworkStatusCode(from: response.value)
            
            if statusCode != 200 {
                //Error
                print("*** NETWORK ERROR: \(statusCode ?? 0) - Something went wrong")
            } else {
                let lyrics = NetworkParser.parseLyrics(response.value)
                completion?(lyrics)
            }
        }
    }
    
    static func requestRandomTrackWithRandomLine(_ completion: TrackAndLineCompletion?) {
        
        requestSongFromRandomPage {
            track in
            
            if let track = track {
                requestLyrics(fromTrack: track) { lyrics in
                    if let lyrics = lyrics {
                        
                        let line = Utility.getRandomLineFromLyrics(lyrics)
                        completion?(track, line)
                    }
                }
            }
        }
    }
    
    
    // MARK: - Artists
    
    static func requestArtists(completion: ArtistsCompletion?) {
        let url = endpoint + "chart.artists.get?page=1&page_size=100&apikey=\(apikey)"
        print("REQUEST FROM URL: \(url)")
        
        let request = AF.request(url)
        
        request.responseJSON {
            response in
            
            let statusCode = NetworkParser.parseNetworkStatusCode(from: response.value)
            
            if statusCode != 200 {
                //Error
                print("*** NETWORK ERROR: \(statusCode ?? 0) - Something went wrong")
            } else {
                let artists = NetworkParser.parseArtistList(response.value)
                completion?(artists)
            }
        }
    }
    
    static func requestRandomArtist(_ number: Int, completion: ArtistsCompletion?) {
        NetworkUtility.requestArtists {
            artists in
            
            if let pickedArray = artists?.choose(number) {
                completion?(Array(pickedArray))
            }
        }
    }
}
