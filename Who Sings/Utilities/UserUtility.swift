//
//  UserUtility.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 06/12/21.
//

import Foundation

class UserUtility {
    
    static var connectedUser: User? {
        if let _connectedUser = _connectedUser {
            return _connectedUser
        } else {
            if let data = UserDefaults().data(forKey: Constants.connectedUserDefaults) {
                // Last connected user
                let decoder = JSONDecoder()
                
                // Decode Note
                _connectedUser = try? decoder.decode(User.self, from: data)
                return _connectedUser
            }
        }
        
        return nil
    }
    
    
    private static var _connectedUser: User?
    
    static func setConnectedUser(_ user: User) {
        // Save last connected user
        let encoder = JSONEncoder()
        let data = try? encoder.encode(user)
        UserDefaults.standard.set(data, forKey: Constants.connectedUserDefaults)
    }
    
    static func disconnectCurrentUser() {
        UserDefaults.standard.set(nil, forKey: Constants.connectedUserDefaults)
    }
    
    
}
