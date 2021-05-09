//
//  MockUser.swift
//  Sainath
//
//  Created by Sainath on 08/05/21.
//  Copyright © 2021 Sainath. All rights reserved.
//

import Foundation
extension User {
    static func with(postid:Int = 1,
                     id: Int = 1,
                     name: String = "Jimmy",
                     email: String = "Swift@gmail.com",
                     body: String = "An object that manages the execution of tasks serially or concurrently on app's main thread or on a background thread" ) -> User
    {
        return User(postId: postid, id: id, name: name, email: email, body:body)
    }
}
