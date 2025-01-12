//
//  HabitViewModel.swift
//  habit-tracker
//
//  Created by Salah Khaled on 12/01/2025.
//


import Foundation

class HabitViewModel {
    
    
    // MARK: - Firebase Realtime
    func addHabit(title: String, completion: @escaping(_ error: String?) -> Void) {
        
        FirebaseManager.shared.addHabit(habitTitle: title) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
}
