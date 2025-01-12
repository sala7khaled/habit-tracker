//
//  HomeController.swift
//  habit-tracker
//
//  Created by Salah Khaled on 12/01/2025.
//

import UIKit
import FirebaseDatabase

class HomeController: UIViewController {
    
    
    // MARK: - Outlets
    
    
    // MARK: - Properties
    let ref = Database.database().reference()
    let userId = "exampleUserId"
    let date = "2025-01-12"
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Habit Tracker"
        
    }
    
    
   

}
