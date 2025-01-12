//
//  HomeViewModel.swift
//  habit-tracker
//
//  Created by Salah Khaled on 12/01/2025.
//


import Foundation

class HomeViewModel {
    
    // MARK: - Properties
    private var habitList = [HabitModel]()
    private var habitStatusList = [HabitStatusModel]()
    private var selectedDate = ""
    
    
    // MARK: - Firebase Realtime
    func getHabitList(completion: @escaping(_ error: String?) -> Void) {
        
        FirebaseManager.shared.fetchHabits { habits, error in
            if let error = error {
                completion(error)
            } else if let habits = habits {
                self.habitList = habits.sorted { $0.title.lowercased() < $1.title.lowercased() }
                completion(nil)
            }
        }
    }

    
    func completeHabit(habitId: String, status: Bool, completion: @escaping(_ error: String?) -> Void) {
        
        FirebaseManager.shared.changeHabitStatus(date: selectedDate, habitId: habitId, status: status) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }

    }
    
    func getHabitStatusList(completion: @escaping(_ error: String?) -> Void) {
        
        FirebaseManager.shared.fetchAllHabitsStatus(forDate: selectedDate) { habitStatus, error in
            if let error = error {
                completion(error)
            } else if let habitStatus = habitStatus {
                self.habitStatusList = habitStatus
                completion(nil)
            }
        }
        
    }
    
    func deleteHabit(habitId: String, completion: @escaping (String?) -> Void) {
        FirebaseManager.shared.deleteHabit(habitId: habitId) { error in
            if let error = error {
                completion(error)
            } else {
                self.removeHabitFromList(habitId: habitId)
                completion(nil)
            }
        }
    }

    
    
    // MARK: - Helper Methods
    func habitsCount() -> Int {
        habitList.count
    }
    
    func getHabit(at index: Int) -> HabitModel {
        habitList[index]
    }
    
    func getHabitStatus(habitId: String) -> Bool {
        return habitStatusList.first(where: { $0.habitId == habitId })?.isCompleted ?? false
    }
    
    func removeHabitFromList(habitId: String) {
        self.habitList = self.habitList.filter { $0.id != habitId }
    }
    
    func setCurrentDate(_ date: String) {
        selectedDate = date
    }

    
}
