//
//  AppServerClient.swift
//  Sainath
//
//  Created by Sainath on 08/05/21.
//  Copyright © 2021 Sainath. All rights reserved.
//

import Alamofire

// MARK: - AppServerClient
class AppServerClient {

    enum GetUsersFailureReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
    }

    typealias GetUserResult = Result<[User], GetUsersFailureReason>
    typealias GetUsersCompletion = (_ result: GetUserResult) -> Void

    func getUsers(completion: @escaping GetUsersCompletion) {
        Alamofire.request("https:jsonplaceholder.typicode.com/posts/1/comments")
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        guard let data = response.data else {
                            completion(.failure(nil))
                            return
                        }

                        let users = try JSONDecoder().decode([User].self, from: data)
                        completion(.success(payload: users))
                    } catch {
                        completion(.failure(nil))
                    }
                case .failure(_):
                    if let statusCode = response.response?.statusCode,
                        let reason = GetUsersFailureReason(rawValue: statusCode) {
                        completion(.failure(reason))
                    }
                    completion(.failure(nil))
                }
        }
    }
}

