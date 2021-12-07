//
//  UserUtility.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 06/12/21.
//

import Foundation

class UserUtility {
    
    // MARK: - Connected user
    
    static var connectedUser: User? {
        if let _connectedUser = _connectedUser {
            return _connectedUser
        } else {
            let user = try? UserDefaults.standard.getObject(forKey: Constants.connectedUserDefaults, castTo: User.self)
            _connectedUser = user
            return user
        }
    }
    
    private static var _connectedUser: User?
    
    static func setConnectedUser(_ user: User) {
        // Save last connected user
        _connectedUser = user
        addUserToStored(user)
        try? UserDefaults.standard.setObject(user, forKey: Constants.connectedUserDefaults)
    }
    
    static func updateConnectedUser() {
        // Save last connected user
        if let _connectedUser = _connectedUser {
            try? UserDefaults.standard.setObject(_connectedUser, forKey: Constants.connectedUserDefaults)
        }
    }
    
    static func disconnectCurrentUser() {
        _connectedUser = nil
        UserDefaults.standard.set(nil, forKey: Constants.connectedUserDefaults)
    }
    
    
    // MARK: - Stored users
    
    static var storedUsers: [User] {
        if let _storedUsers = _storedUsers {
            return _storedUsers
        } else {
            let users = try? UserDefaults.standard.getObject(forKey: Constants.storedUsersDefaults, castTo: Array<User>.self)
            _storedUsers = users
            return users ?? []
        }
        
    }
    
    private static var _storedUsers: [User]?
    
    static func addUserToStored(_ user: User) {
        // Save last connected user
        var arrayToStore = storedUsers
        arrayToStore.append(user)
        try? UserDefaults.standard.setObject(arrayToStore, forKey: Constants.storedUsersDefaults)
    }
    
    
    static func getUsersOrderedByBest() -> [User] {
        return storedUsers.sorted { firstUser, secondUser in
            let firstPoints = firstUser.bestScore?.points ?? 0
            let secondPoints = secondUser.bestScore?.points ?? 0
            
            return firstPoints > secondPoints
        }
    }
}

extension UserDefaults: ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }
    
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}

protocol ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}


enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    
    var errorDescription: String? {
        rawValue
    }
}
