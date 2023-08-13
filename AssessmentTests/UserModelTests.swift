//
//  UserModelTests.swift
//  AssessmentTests
//
//  Created by Rushit on 13/08/23.
//

import XCTest

final class UserModelTests: XCTestCase {
    
    var user: User!

    override func setUpWithError() throws {
        user = try User(name: "Test", username: "Test", password: "Test")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUsernameBase64Encoding() throws {
        XCTAssertEqual(user.username,"VGVzdA==")
    }
    
    func testUsernameDecodedString() throws {
        XCTAssertEqual(user.readableUsername, "Test")
    }
    
    func testPasswordBase64Encoding() throws {
        XCTAssertEqual(user.password, "VGVzdA==")
    }

}
