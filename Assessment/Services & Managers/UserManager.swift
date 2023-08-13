//
//  UserManager.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import Foundation

final class UserManager {
    
    // MARK: - Properties
    
    static var shared: UserManager = UserManager()
    
    private var loginContainer: UserDefaults = UserDefaults(suiteName: "LOGIN_DATABASE")!
    
    private enum LoginContainerKeys: String {
        case currentUser = "CURRENT_USER"
        case users = "ALL_USERS"
    }
    
    var isLoggedIn: Bool { return currentUser != nil }
    
    var currentUser: User? {
        get {
            guard
                let data = loginContainer.data(forKey: LoginContainerKeys.currentUser.rawValue),
                let user = try? JSONDecoder().decode(User.self, from: data)
            else { return nil }
            
            return user
        }
        set {
            guard
                let newValue = newValue,
                let data = try? JSONEncoder().encode(newValue)
            else {
                loginContainer.removeObject(forKey: LoginContainerKeys.currentUser.rawValue)
                return
            }
            
            loginContainer.set(data, forKey: LoginContainerKeys.currentUser.rawValue)
        }
    }
    
    private(set) lazy var users: Set<User> = {
        guard
            let data = loginContainer.data(forKey: LoginContainerKeys.users.rawValue),
            let users = try? JSONDecoder().decode([User].self, from: data)
        else { return [] }
        
        return Set(users)
    }()
    
    // MARK: - Lifecycle
    
    #if TEST
    init() {}
    #else
    private init() {}
    #endif
    
    // MARK: - Functionalities
    
    internal func login(
        username: String,
        password: String
    ) throws {
        
        guard
            let usernameData = username.data(using: .utf8),
            let passwordData = password.data(using: .utf8)
        else { throw LoginError.incorrectUsernameOrPassword }
        
        let username = usernameData.base64EncodedString()
        let password = passwordData.base64EncodedString()
        
        if let user = users.first(
            where: { $0.username == username && $0.password == password }
        ) {
            currentUser = user
        } else {
            throw LoginError.incorrectUsernameOrPassword
        }
        
    }
    
    internal func logout() {
        currentUser = nil
    }
    
    internal func register(
        name: String,
        username: String,
        password: String
    ) throws {
        let user = try User(name: name, username: username, password: password)
        if users.contains(user) {
            throw LoginError.userAleradyRegistered
        }
        users.insert(user)
        try saveAllUsers()    
    }
    
    private func saveAllUsers() throws {
        guard
            let data = try? JSONEncoder().encode(users)
        else {
            throw LoginError.saveToContainerFailed
        }
        
        loginContainer.set(data, forKey: LoginContainerKeys.users.rawValue)
    }
    
    // MARK: - Error
    
    private enum LoginError: Error, LocalizedError {
        case saveToContainerFailed
        case incorrectUsernameOrPassword
        case userAleradyRegistered
        
        var errorDescription: String? {
            switch self {
            case .saveToContainerFailed: return "Error while saving the user informations. Please check storage available."
            case .incorrectUsernameOrPassword: return "Invalid username or password. Please enter valid credentials."
            case .userAleradyRegistered: return "This account is username is already registeres, please try to login."
            }
        }
    }
}
