//
//  HabitStatusModel.swift
//  habit-tracker
//
//  Created by Salah Khaled on 12/01/2025.
//

import Foundation

struct HabitStatusModel {
    let habitId: String
    let isCompleted: Bool
    
    init(habitId: String, isCompleted: Bool) {
        self.habitId = habitId
        self.isCompleted = isCompleted
    }
    
    static func fromDictionary(_ dictionary: [String: Bool]) -> [HabitStatusModel] {
        var habitStatuses: [HabitStatusModel] = []
        for (habitId, isCompleted) in dictionary {
            let status = HabitStatusModel(habitId: habitId, isCompleted: isCompleted)
            habitStatuses.append(status)
        }
        return habitStatuses
    }
}
