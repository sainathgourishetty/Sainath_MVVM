//
//  UserTests.swift
//  SainathTests
//
//  Created by Sainath on 08/05/21.
//  Copyright © 2021 Sainath. All rights reserved.
//


import XCTest

class UserTests: XCTestCase {

    func testSuccessfulInit() {
        let testSuccessfulJSON: JSON = ["postId": 1,
                                        "id": 0,
                                    "name": "Jimmy",
                                    "email": "Swifty@gmail.com",
                                    "body": "An object that manages the execution of tasks serially or concurrently on app's main thread or on a background thread"]

        XCTAssertNotNil(User(json: testSuccessfulJSON))
    }
}

// Mark: - extension User
private extension User {
    init?(json: JSON) {
        guard let postId = json["postId"] as? Int,
             let id = json["id"] as? Int,
            let name = json["name"] as? String,
            let email = json["email"] as? String,
            let body = json["body"] as? String else {
                return nil
        }
        self.postId = postId
        self.id = id
        self.name = name
        self.email = email
        self.body = body
    }
}
