//
//  UIViewController + Extensions.swift
//  habit-tracker
//
//  Created by Salah Khaled on 12/01/2025.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String,
                   message: String,
                   buttonTitle: String = "Alright") {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showActionAlert(title: String,
                         message: String,
                         buttonTitle: String = "Alright",
                         withCancel: Bool = false,
                         completion: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
            completion()
        }))
        
        if withCancel {
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}
