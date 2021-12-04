//
//  NetworkParser.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 02/12/21.
//

import Foundation

class NetworkParser {
    
    // MARK: - Base response
    
    static func parseNetworkStatusCode(from response: Any?) -> Int? {
        guard let response = response as? NSDictionary else { return nil }

        if let message = response["message"] as? NSDictionary {
            if let header = message["header"] as? NSDictionary {
                let statusCode = header["status_code"] as? Int
                
                return statusCode
            }
        }
        
        // Error in structure
        return nil
    }
    
    static func parseNetworkBody(from response: NSDictionary?) -> NSDictionary? {
        guard let response = response else { return nil }

        if let message = response["message"] as? NSDictionary {
            return message["body"] as? NSDictionary
        }
        
        // Error in structure
        return nil
    }
    
    // MARK: - Track
    
    static func parseTrackList(_ dictionary: Any?) -> [Track] {
        guard let dictionary = dictionary as? NSDictionary else {
            return []
        }

        guard let body = parseNetworkBody(from: dictionary) else {
            return []
        }
        
        guard let trackList = body["track_list"] as? [NSDictionary] else {
            return []
        }
        
        var parsedObjects: [Track] = []
        
        for track in trackList {
            if let object = parseTrack(track) {
                parsedObjects.append(object)
            }
        }
        
        return parsedObjects
    }
    
    static func parseTrack(_ dictionary: NSDictionary) -> Track? {
        if let track = dictionary["track"] as? NSDictionary {
            if let data = try? JSONSerialization.data(withJSONObject: track, options: .prettyPrinted) {
                if let parsedObject = try? JSONDecoder().decode(Track.self, from: data) {
                    return parsedObject
                }
            }
        }
        
        return nil
    }
    
    
    // MARK: - Lyrics
    
    static func parseLyrics(_ dictionary: Any?) -> String? {
        guard let dictionary = dictionary as? NSDictionary else {
            return nil
        }

        guard let body = parseNetworkBody(from: dictionary) else {
            return nil
        }
        
        guard let lyrics = body["lyrics"] as? NSDictionary else {
            return nil
        }
        
        let parsedObject = lyrics["lyrics_body"] as? String
        return parsedObject
    }
    
    // MARK: - Artists
    
    static func parseArtistList(_ dictionary: Any?) -> [Artist] {
        guard let dictionary = dictionary as? NSDictionary else {
            return []
        }

        guard let body = parseNetworkBody(from: dictionary) else {
            return []
        }
        
        guard let artistList = body["artist_list"] as? [NSDictionary] else {
            return []
        }
        
        var parsedObjects: [Artist] = []
        
        for artist in artistList {
            if let object = parseArtist(artist) {
                parsedObjects.append(object)
            }
        }
        
        return parsedObjects
    }
    
    static func parseArtist(_ dictionary: NSDictionary) -> Artist? {
        if let artist = dictionary["artist"] as? NSDictionary {
            if let data = try? JSONSerialization.data(withJSONObject: artist, options: .prettyPrinted) {
                if let parsedObject = try? JSONDecoder().decode(Artist.self, from: data) {
                    return parsedObject
                }
            }
        }
        
        return nil
    }
}
