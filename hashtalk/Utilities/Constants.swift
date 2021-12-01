//
//  Constants.swift
//  hashtalk
//
//  Created by Yuşa Sarısoy on 18.04.2021.
//

struct Constants {
  static let appName = "💬 Hashtalk"
  static let cellIdentifier = "ReusableCell"
  static let cellNibName = "MessageCell"
  static let registerSegue = "RegisterToChat"
  static let logInSegue = "LogInToChat"

  struct BrandColors {
    static let purple = "BrandPurple"
    static let lightPurple = "BrandLightPurple"
    static let blue = "BrandBlue"
    static let lighBlue = "BrandLightBlue"
  }

  struct Firestore {
    static let collectionName = "messages"
    static let senderField = "sender"
    static let bodyField = "body"
    static let dateField = "date"
  }
}
