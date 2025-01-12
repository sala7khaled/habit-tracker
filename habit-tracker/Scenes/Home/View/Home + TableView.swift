//
//  Home + TableView.swift
//  habit-tracker
//
//  Created by Salah Khaled on 12/01/2025.
//

import UIKit

extension HomeController: UITableViewDelegateAndDataSource {
    
    func setupTableView() {
        tableView.initialize(cellClass: HabitCell.self, delegate: self, dataSource: self)
        tableView.separatorInset = .zero
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.habitsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: HabitCell.self)
        cell.delegate = self
        
        let habit = viewModel.getHabit(at: indexPath.row)
        let isCompleted = viewModel.getHabitStatus(habitId: habit.id)
        
        cell.configure(habit: habit, isCompleted: isCompleted)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            
            let habit = self.viewModel.getHabit(at: indexPath.row)
            
            self.showLoading()
            self.viewModel.deleteHabit(habitId: habit.id) { error in
                self.hideLoading()
                
                if let error = error {
                    self.showAlert(title: "Error", message: error)
                    completionHandler(false)
                } else {
                    self.getHabitList()
                    completionHandler(true)
                }
            }
        }
        
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}

extension HomeController: HabitCellDelegate {
    func didCompleteHabit(at indexPath: IndexPath) {
        let habit = viewModel.getHabit(at: indexPath.row)
        let isCompleted = viewModel.getHabitStatus(habitId: habit.id)
        
        viewModel.completeHabit(habitId: habit.id, status: !isCompleted) { [weak self] error in
            guard let self = self else { return }
            
            if let error {
                self.showAlert(title: "Error", message: error)
                return
            }
            getHabitList()
        }
    }
}
