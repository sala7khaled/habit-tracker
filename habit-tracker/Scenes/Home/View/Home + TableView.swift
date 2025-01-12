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
    
}


extension HomeController: HabitCellDelegate {
    func didCompleteHabit(at indexPath: IndexPath) {
        let habit = viewModel.getHabit(at: indexPath.row)
        let isCompleted = viewModel.getHabitStatus(habitId: habit.id)
        
        showLoading()
        
        viewModel.completeHabit(habitId: habit.id, date: "12-01-2025", status: !isCompleted) { [weak self] error in
            guard let self = self else { return }
            
            self.hideLoading()
            if let error {
                self.showAlert(title: "Error", message: error)
                return
            }
            getHabitList()
        }
    }
}
