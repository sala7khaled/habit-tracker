//
//  HabitController.swift
//  habit-tracker
//
//  Created by Salah Khaled on 12/01/2025.
//

import UIKit

class HabitController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var habitTextfield: UITextField!
    
    
    // MARK: - Properties
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }


    // MARK: - Methods
    func setupViews() {
        title = "Add Habit"
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissController))
        cancelButton.tintColor = .gray
        navigationItem.leftBarButtonItem = cancelButton
        navigationController?.navigationBar.backgroundColor = .systemGray6
    }
    
    @objc func dismissController() {
        self.dismiss(animated: true)
    }
    
    func validateInput() -> Bool {
        guard let habit = habitTextfield.text, !habit.isEmpty else {
            showAlert(title: "Error", message: "Please enter a habit.")
            return false
        }
        
        let invalidCharacters = CharacterSet(charactersIn: ".#$[]")
        if habit.rangeOfCharacter(from: invalidCharacters) != nil {
            showAlert(title: "Error", message: "Habit cannot contain . # $ [ ]")
            return false
        }
        
        return true
    }
    
    
    // MARK: - Actions
    @IBAction func addHabitButtonClicked(_ sender: Any) {
        
        guard validateInput() else {
            return
        }
        
        FirebaseManager.shared.addHabit(habitTitle: habitTextfield.text ?? "") { error in
            if let error = error {
                self.showAlert(title: "Error", message: error)
            } else {
                print("")
                self.showActionAlert(title: "Success", message: "Habit added successfully") {
                    self.dismissController()
                }
            }
        }

    }
    
}
