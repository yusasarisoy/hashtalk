//
//  WelcomeViewController.swift
//  hashtalk
//
//  Created by Yuşa Sarısoy on 22.03.2021.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateAppName() // This function allows to animate the app name which is 'Hashtalk'.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    /// This function allows to animate the app name which is 'Hashtalk'.
    private func animateAppName() {
        titleLabel.text = ""
        var characterIndex = 0.0
        let titleText = Constants.appName
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * characterIndex, repeats: false) { _ in
                self.titleLabel.text?.append(letter)
            }
            characterIndex += 1
        }
    }
}
