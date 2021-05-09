//
//  UserTableViewCell.swift
//  Sainath
//
//  Created by Sainath on 08/05/21.
//  Copyright © 2021 Sainath. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

     @IBOutlet weak var labelName: UILabel?
      @IBOutlet weak var labelEmail: UILabel?
     @IBOutlet weak var labelComment: UILabel?

      var viewModel: UserCellViewModel? {
          didSet {
              bindViewModel()
          }
      }

      private func bindViewModel() {
          labelName?.text = viewModel?.nameData
          labelEmail?.text = viewModel?.emaildata
          labelComment?.text = viewModel?.comment
      }

}
