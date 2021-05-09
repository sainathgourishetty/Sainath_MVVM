//
//  UserTableViewController.swift
//  Sainath
//
//  Created by Sainath on 08/05/21.
//  Copyright © 2021 Sainath. All rights reserved.
//

import UIKit
import PKHUD

class UserTableViewController: UITableViewController {

    let viewModel: UsersTableViewViewModel = UsersTableViewViewModel()

    public override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.getUsers()
    }

    func bindViewModel() {
        viewModel.userCells.bindAndFire() { [weak self] _ in
            self?.tableView?.reloadData()
        }

        viewModel.onShowError = { [weak self] alert in
            self?.presentSingleButtonDialog(alert: alert)
        }


        viewModel.showLoadingHud.bind() { [weak self] visible in
            if let `self` = self {
                PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
                visible ? PKHUD.sharedHUD.show(onView: self.view) : PKHUD.sharedHUD.hide()
            }
        }
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

           if segue.identifier == "showUserComment",
               let destinationViewController = segue.destination as? UserDetailViewController,
               let indexPath = tableView.indexPathForSelectedRow {

               switch viewModel.userCells.value[indexPath.row] {
               case .normal(let viewModel):
                destinationViewController.viewModel = viewModel.userItem
                  
               case .empty, .error:
                   // nop
                   break
               }
           }
       }

   
}

// MARK: - UITableViewDelegate
extension UserTableViewController {

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userCells.value.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch viewModel.userCells.value[indexPath.row] {
        case .normal(let viewModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserTableViewCell else {
                return UITableViewCell()
            }

            cell.viewModel = viewModel
            return cell
        case .error(let message):
            let cell = UITableViewCell()
            cell.isUserInteractionEnabled = false
            cell.textLabel?.text = message
            return cell
        case .empty:
            let cell = UITableViewCell()
            cell.isUserInteractionEnabled = false
            cell.textLabel?.text = "No data available"
            return cell
        }
    }
}

extension UserTableViewController: SingleButtonDialogPresenter { }
