//
//  BaseController.swift
//  habit-tracker
//
//  Created by Salah Khaled on 12/01/2025.
//

import UIKit

public class BaseController: UIViewController {
    
    var loading: LoadingController?
        
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        loading = LoadingController()
    }
    
}

// MARK: - Loading
extension BaseController {
    
    /// Show Loading View over Full Screen
    func showLoading() {
        DispatchQueue.main.async {
            self.loading?.show()
        }
    }

    /// Hide Loading View
    func hideLoading() {
        DispatchQueue.main.async {
            self.loading?.close()
        }
    }
    
}
