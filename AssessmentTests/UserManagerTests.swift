//
//  UserManagerTests.swift
//  AssessmentTests
//
//  Created by Rushit on 13/08/23.
//

import XCTest
import Foundation

final class UserManagerTests: XCTestCase {
    
    static var newUserName: String = "Test \(Date().timeIntervalSinceReferenceDate)"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNewRegistration() throws {
        try UserManager.shared.register(name: "Test", username: Self.newUserName, password: "Test")
        let base64Username = Self.newUserName.data(using: .utf8)?.base64EncodedString() ?? ""
        XCTAssertTrue(UserManager.shared.users.contains(where: { $0.username == base64Username }))
    }
    
    func testAlreadyRegistered() throws {
        XCTAssertThrowsError(try UserManager.shared.register(name: "Test", username: "Test", password: "Test"))
    }
    
    func testLogin() throws {
        try UserManager.shared.login(username: "Test", password: "Test")
        XCTAssertNotNil(UserManager.shared.currentUser)
    }
    
    func testLoginFailure() throws {
        XCTAssertThrowsError(try UserManager.shared.login(username: "Test", password: "Wrong"))
    }
    
    func testLogout() throws {
        UserManager.shared.logout()
        XCTAssertNil(UserManager.shared.currentUser)
    }

}
