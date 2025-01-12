//
//  Home + DatePicker.swift
//  habit-tracker
//
//  Created by Salah Khaled on 12/01/2025.
//

import Foundation

extension HomeController {
    
    // MARK: - Actions
    @IBAction func didChangeDate(_ sender: Any) {
        changeCurrentDate()
    }
    
    // MARK: - Methods
    func setupDatePicker() {
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = Locale(identifier: "en")
        
        datePicker.setDate(Date(), animated: false)
        changeCurrentDate()
    }
    
    func changeCurrentDate() {
        viewModel.setCurrentDate(dateFormatter.string(from: datePicker.date))
        getHabitList()
    }
}
