//
//  ChatViewController.swift
//  hashtalk
//
//  Created by Yuşa Sarısoy on 22.03.2021.
//

import Firebase
import UIKit

class ChatViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var messageTextfield: UITextField!

  let database = Firestore.firestore()

  var messages: [Message] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = self
    navigationItem.hidesBackButton = true // Hide the "Back" button.
    tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil),
                       forCellReuseIdentifier: Constants.cellIdentifier) // Register the custom UITableViewCell.
    retrieveMessages() // This function provides to retrieve the messages from the Firestore.
  }

  @IBAction func sendPressed(_ sender: UIButton) {
    saveMessageToFirestore() // This function provides to save the message to the Firestore.
  }

  @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
    do {
      try Auth.auth().signOut()
      navigationController?.popToRootViewController(animated: true)
    } catch let signOutError as NSError {
      print("Error while signing out %@:", signOutError)
    }
  }

  // MARK: - Helpers

  /// This function provides to retrieve the messages from the Firestore.
  private func retrieveMessages() {
    database.collection(Constants.Firestore.collectionName)
      .order(by: Constants.Firestore.dateField)
      .addSnapshotListener { (querySnapshot, error) in
        self.messages = [] // Make the messages array empty.
        if let error = error {
          print("An error occurred while loading the message from the Firestore: \(error.localizedDescription)")
        } else {
          if let snapshotDocuments = querySnapshot?.documents {
            for doc in snapshotDocuments {
              let data = doc.data() // Get the message data.
              if let sender = data[Constants.Firestore.senderField] as? String,
                 let body = data[Constants.Firestore.bodyField] as? String {
                let newMessage = Message(sender: sender, body: body) // Get the message sender and message.
                self.messages.append(newMessage) // Add the message to the messages array.
                DispatchQueue.main.async {
                  self.tableView.reloadData() // Reload the UITableView to display message.
                  let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                  self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                }
              }
            }
          }
        }
      }
  }

  /// This function provides to save the message to the Firestore.
  private func saveMessageToFirestore() {
    if let messageBody = messageTextfield.text,
       let messageSender = Auth.auth().currentUser?.email {
      database.collection(Constants.Firestore.collectionName).addDocument(data: [
        Constants.Firestore.senderField: messageSender,
        Constants.Firestore.bodyField: messageBody,
        Constants.Firestore.dateField: Date().timeIntervalSince1970
      ]) { (error) in
        if let error = error {
          print("The following error occurred while saving data to the Firestore: \(error.localizedDescription)")
        } else {
          print("Data has been saved successfully!")
          DispatchQueue.main.async {
            self.messageTextfield.text?.removeAll() // Clear the UITextField.
          }
        }
      }
    }
  }
}

extension ChatViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    messages.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier,
                                                for: indexPath) as? MessageCell {
      let message = messages[indexPath.row]
      cell.labelMessage.text = messages[indexPath.row].body // Show the message body.
      cell.selectionStyle = .none // Hide the highlight color of the UITableViewCell.
      let isCurrentUser = message.sender == Auth.auth().currentUser?.email
      cell.imageViewMe.isHidden = !isCurrentUser
      cell.imageViewYou.isHidden = isCurrentUser
      cell.viewMessageBubble.backgroundColor = UIColor(named: isCurrentUser
                                                       ? Constants.BrandColors.lightPurple
                                                       : Constants.BrandColors.purple)
      cell.labelMessage.textColor = UIColor(named: isCurrentUser
                                            ? Constants.BrandColors.purple
                                            : Constants.BrandColors.lightPurple)
      return cell
    }
    return UITableViewCell()
  }
}
