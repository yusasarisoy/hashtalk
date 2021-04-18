//
//  ChatViewController.swift
//  hashtalk
//
//  Created by Yuşa Sarısoy on 22.03.2021.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Hashtalk" // Set the title as app name.
        navigationItem.hidesBackButton = true // Hide the "Back" button.
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error while signing out %@:", signOutError)
        }
    }
}
