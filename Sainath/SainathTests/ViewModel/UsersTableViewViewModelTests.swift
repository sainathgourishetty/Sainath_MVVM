//
//  UserTableViewViewModelTests.swift
//  SainathTests
//
//  Created by Sainath on 08/05/21.
//  Copyright © 2021 Sainath. All rights reserved.
//

import XCTest

class UsersTableViewViewModelTests: XCTestCase {

     // MARK: - getUser
     func testNormalUserCells() {
         let appServerClient = MockAppServerClient()
         appServerClient.getUsersResult = .success(payload: [User.with()])

         let viewModel = UsersTableViewViewModel(appServerClient: appServerClient)
         viewModel.getUsers()

         guard case .some(.normal(_)) = viewModel.userCells.value.first else {
             XCTFail()
             return
         }
     }

     func testEmptyUserCells() {
         let appServerClient = MockAppServerClient()
         appServerClient.getUsersResult = .success(payload: [])

         let viewModel = UsersTableViewViewModel(appServerClient: appServerClient)
         viewModel.getUsers()

         guard case .some(.empty) = viewModel.userCells.value.first else {
             XCTFail()
             return
         }
     }

     func testErrorUserCells() {
         let appServerClient = MockAppServerClient()
         appServerClient.getUsersResult = .failure(AppServerClient.GetUsersFailureReason.notFound)

         let viewModel = UsersTableViewViewModel(appServerClient: appServerClient)
         viewModel.getUsers()

         guard case .some(.error(_)) = viewModel.userCells.value.first else {
             XCTFail()
             return
         }
     }

}
private final class MockAppServerClient: AppServerClient {
    var getUsersResult: AppServerClient.GetUserResult?
  

    override func getUsers(completion: @escaping AppServerClient.GetUsersCompletion) {
        completion(getUsersResult!)
    }

 
}
