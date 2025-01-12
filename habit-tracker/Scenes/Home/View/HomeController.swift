//
//  HomeController.swift
//  habit-tracker
//
//  Created by Salah Khaled on 12/01/2025.
//

import UIKit
import FirebaseDatabase

class HomeController: BaseController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var emptyStack: UIStackView!
    @IBOutlet weak var habitsLabel: UILabel!
    
    
    // MARK: - Properties
    let viewModel = HomeViewModel()
    let dateFormatter = DateFormatter()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupTableView()
        setupDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getHabitList(firstLoad: true)
    }
    
    
    // MARK: - Methods
    func setupViews() {
        super.viewDidLoad()
        
        title = "Habit Tracker"
        habitsLabel.text = Shared.username != nil ? "\(Shared.username ?? "")'s habits" : "Habits"
        
        let habitButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(navigateToHabit))
        navigationItem.rightBarButtonItem = habitButton
    }
    
    @objc private func navigateToHabit() {
        let nav = UINavigationController(rootViewController: HabitController())
        self.present(nav, animated: true)
    }
    
    
    func getHabitList(firstLoad: Bool = false) {
        
        if firstLoad {
            showLoading()
        }
        
        viewModel.getHabitList { [weak self] error in
            guard let self = self else { return }
            
            self.hideLoading()
            if let error {
                self.showAlert(title: "Error", message: error)
                return
            }
            // Handle Success
            reloadData()
        }
        
        viewModel.getHabitStatusList { [weak self] error in
            guard let self = self else { return }
            
            self.hideLoading()
            if let error {
                self.showAlert(title: "Error", message: error)
                return
            }
            // Handle Success
            reloadData()
        }
        
        
    }
    
    func reloadData() {
        tableView.reloadData()
        emptyStack.isHidden = viewModel.habitsCount() > 0
    }
    

}
