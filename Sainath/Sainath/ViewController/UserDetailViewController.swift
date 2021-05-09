//
//  UserDetailViewController.swift
//  Sainath
//
//  Created by Sainath on 08/05/21.
//  Copyright © 2021 Sainath. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    var viewModel: User?
    @IBOutlet var userCommentTextView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()

        // Do any additional setup after loading the view.
    }
    func bindViewModel() {
        userCommentTextView?.text = viewModel?.comment
    }

}
