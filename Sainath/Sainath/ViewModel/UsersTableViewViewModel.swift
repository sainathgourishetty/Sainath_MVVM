//
//  UsersTableViewViewModel.swift
//  Sainath
//
//  Created by Sainath on 08/05/21.
//  Copyright © 2021 Sainath. All rights reserved.
//

class UsersTableViewViewModel {

    enum UserTableViewCellType {
        case normal(cellViewModel: UserCellViewModel)
        case error(message: String)
        case empty
    }

    var onShowError: ((_ alert: SingleButtonAlert) -> Void)?
    let showLoadingHud: Bindable = Bindable(false)

    let userCells = Bindable([UserTableViewCellType]())
    let appServerClient: AppServerClient

    init(appServerClient: AppServerClient = AppServerClient()) {
        self.appServerClient = appServerClient
    }

    func getUsers() {
        showLoadingHud.value = true
        appServerClient.getUsers(completion: { [weak self] result in
            self?.showLoadingHud.value = false
            switch result {
            case .success(let users):
                guard users.count > 0 else {
                    self?.userCells.value = [.empty]
                    return
                }
                self?.userCells.value = users.compactMap { .normal(cellViewModel: $0 as UserCellViewModel)}
            case .failure(let error):
                self?.userCells.value = [.error(message: error?.getErrorMessage() ?? "Loading failed, check network connection")]
            }
        })
    }
}

fileprivate extension AppServerClient.GetUsersFailureReason {
    func getErrorMessage() -> String? {
        switch self {
        case .unAuthorized:
            return "Please login to load your Users."
        case .notFound:
            return "Could not complete request, please try again."
        }
    }
}


