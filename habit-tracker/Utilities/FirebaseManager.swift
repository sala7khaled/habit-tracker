//
//  FirebaseManager.swift
//  habit-tracker
//
//  Created by Salah Khaled on 12/01/2025.
//


import FirebaseDatabase

class FirebaseManager {
    
    // MARK: - Properties
    static let shared = FirebaseManager()
    private let databaseRef: DatabaseReference
    
    // MARK: - Init
    private init() {
        self.databaseRef = Database.database().reference()
    }
    
    // MARK: - Public Methods
    
    /// Add habit
    func addHabit(habitTitle: String, completion: @escaping (String?) -> Void) {
        guard let username = Shared.username else {
            completion("Username is not set")
            return
        }
        let habitId = databaseRef.child("users/\(username)/habits").childByAutoId().key
        let habitData: [String: Any] = ["title": habitTitle]
        
        guard let habitId = habitId else {
            completion("Failed to generate habitId")
            return
        }
        databaseRef.child("users/\(username)/habits/\(habitId)").setValue(habitData, withCompletionBlock: { error, _ in
            completion(error?.localizedDescription)
        })
    }
    
    /// Fetch habits
    func fetchHabits(completion: @escaping ([HabitModel]?, String?) -> Void) {
        guard let username = Shared.username else {
            completion(nil, "Username is not set")
            return
        }
        
        databaseRef.child("users/\(username)/habits").observe(.value) { snapshot in
            if let habitsData = snapshot.value as? [String: [String: Any]] {
                let habits = habitsData.compactMap { (id, data) -> HabitModel? in
                    return HabitModel(id: id, dictionary: data)
                }
                completion(habits, nil)
            } else {
                completion([], nil)
            }
        }
    }

    
    /// Change habit's status for a specific date
    func changeHabitStatus(date: String, habitId: String, status: Bool, completion: @escaping (String?) -> Void) {
        guard let username = Shared.username else {
            completion("Username is not set")
            return
        }
        
        let habitCompletionRef = databaseRef.child("users/\(username)/progress/\(date)/\(habitId)")
        habitCompletionRef.setValue(status) { error, _ in
            completion(error?.localizedDescription)
        }
    }
    
    /// Fetch all habits (completed + not completed) for a specific date
    func fetchAllHabitsStatus(forDate date: String, completion: @escaping ([HabitStatusModel]?, String?) -> Void) {
        guard let username = Shared.username else {
            completion(nil, "Username is not set")
            return
        }
        databaseRef.child("users/\(username)/progress/\(date)").observe(.value) { snapshot in
            if let completedHabits = snapshot.value as? [String: Bool] {
                let habitStatuses = HabitStatusModel.fromDictionary(completedHabits)
                completion(habitStatuses, nil)
            } else {
                completion([], nil)
            }
        }
    }
    
    /// Delete a specific habit
    func deleteHabit(habitId: String, completion: @escaping (String?) -> Void) {
        guard let username = Shared.username else {
            completion("Username is not set")
            return
        }
        databaseRef.child("users/\(username)/habits/\(habitId)").removeValue { error, _ in
            completion(error?.localizedDescription)
        }
    }

}
