//
//  User.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import Foundation

struct User: Codable {
    internal init(name: String, username: String, password: String) throws {
        self.name = name
        
        guard
            let usernameData = username.data(using: .utf8)
        else { throw UserError.base64EncodingFailed }
        self.username = usernameData.base64EncodedString()
        
        guard
            let passwordData = password.data(using: .utf8)
        else { throw UserError.base64EncodingFailed }
        self.password = passwordData.base64EncodedString()
    }
    
    var name: String
    var username: String
    var password: String
}

extension User {
    var readableUsername: String? {
        guard
            let usernameData = Data(base64Encoded: username)
        else { return nil }
        
        return String(data: usernameData, encoding: .utf8)
    }
}

extension User: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(username)
        hasher.combine(password)
    }
}

extension User: Identifiable {
    var id: String { username }
}

extension User: Equatable {
    static func == (_ lhs: User, _ rhs: User) -> Bool {
        lhs.name == rhs.name &&
        lhs.username == rhs.username &&
        lhs.password == rhs.password
    }
}

enum UserError: Error {
    case base64EncodingFailed
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .base64EncodingFailed: return "Failed to create a user. Please try some other credentials."
        }
    }
}
