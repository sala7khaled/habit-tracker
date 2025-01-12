//
//  LoginController.swift
//  habit-tracker
//
//  Created by Salah Khaled on 12/01/2025.
//

import UIKit

class LoginController: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var userTextfield: UITextField!
    
    
    // MARK: - Properties
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Enter username"
    }
    
    // MARK: - Methods
    func validateInput() -> Bool {
        guard let username = userTextfield.text, !username.isEmpty else {
            showAlert(title: "Error", message: "Please enter a username.")
            return false
        }
        
        let invalidCharacters = CharacterSet(charactersIn: ".#$[]")
        if username.rangeOfCharacter(from: invalidCharacters) != nil {
            showAlert(title: "Error", message: "Username cannot contain . # $ [ ]")
            return false
        }
        
        return true
    }
    
    func navigateToHome() {
        let homeVC = HomeController()
        let nav = NavController(root: homeVC)
        
        let window = UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
        window?.makeKeyAndVisible()
        window?.rootViewController = nav
    }


    // MARK: - Actions
    @IBAction func continueButtonClicked(_ sender: Any) {
        guard validateInput() else {
            return
        }
        Shared.username = userTextfield.text
        navigateToHome()
    }
    
}
