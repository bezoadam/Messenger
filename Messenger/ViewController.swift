//
//  ViewController.swift
//  Messenger
//
//  Created by Adam Bezák on 10.4.17.
//  Copyright © 2017 Adam Bezák. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
                
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
    }

    func handleLogout() {
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil )
    }
}

