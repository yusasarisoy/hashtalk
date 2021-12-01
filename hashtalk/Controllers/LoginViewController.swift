//
//  LoginViewController.swift
//  hashtalk
//
//  Created by Yuşa Sarısoy on 22.03.2021.
//

import Firebase
import UIKit

class LoginViewController: UIViewController {

  @IBOutlet weak var emailTextfield: UITextField!
  @IBOutlet weak var passwordTextfield: UITextField!

  @IBAction func loginPressed(_ sender: UIButton) {
    if let email = emailTextfield.text, let password = passwordTextfield.text {
      Auth.auth().signIn(withEmail: email, password: password) { _, error in
        if let error = error {
          print(error)
        } else {
          self.performSegue(withIdentifier: Constants.logInSegue, sender: self)
        }
      }
    }
  }
}
