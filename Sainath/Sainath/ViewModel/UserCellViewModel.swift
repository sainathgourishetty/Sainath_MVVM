//
//  UserCellViewModel.swift
//  Sainath
//
//  Created by Sainath on 08/05/21.
//  Copyright © 2021 Sainath. All rights reserved.
//


protocol UserCellViewModel {
    var userItem: User { get }
    var nameData: String { get }
    var emaildata: String { get }
    var comment: String { get }
}

extension User: UserCellViewModel {
    var userItem: User {
        return self
    }
    var nameData: String {
        return name
    }
    var emaildata: String {
        return email
    }
    var comment: String {
        return body
    }
}

