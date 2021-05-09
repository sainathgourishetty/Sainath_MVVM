//
//  Result.swift
//  Sainath
//
//  Created by Sainath on 08/05/21.
//  Copyright © 2021 Sainath. All rights reserved.
//

enum Result<T, U: Error> {
    case success(payload: T)
    case failure(U?)
}

enum EmptyResult<U: Error> {
    case success
    case failure(U?)
}
