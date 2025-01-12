//
//  LoadingController.swift
//  habit-tracker
//
//  Created by Salah Khaled on 12/01/2025.
//

import UIKit

class LoadingController: UIViewController {
    
    @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorLoading.startAnimating()
    }
    
    func show() {
        DispatchQueue.main.async {
            let keyWindow = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .map({$0 as? UIWindowScene})
            .compactMap({ $0 })
            .first?.windows
            .filter({ $0.isKeyWindow }).first
            keyWindow?.addSubview(self.view)
            
            self.view.frame = UIScreen.main.bounds
            self.view.alpha = 0
            
            UIView.animate(withDuration: 0.2, animations: {
                self.view.alpha = 1
            })
        }
    }
    
    func close() {
        DispatchQueue.main.async {
            self.view.alpha = 1
            UIView.animate(withDuration: 0.2, animations: {
                self.view.alpha = 0
            }, completion: { _ in self.view.removeFromSuperview() })
        }
    }
}
