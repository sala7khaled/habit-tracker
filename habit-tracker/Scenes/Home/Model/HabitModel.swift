//
//  HabitModel.swift
//  habit-tracker
//
//  Created by Salah Khaled on 12/01/2025.
//

import Foundation

struct HabitModel {
    let id: String
    let title: String
    
    init(id: String, title: String) {
        self.id = id
        self.title = title
    }
    
    init?(id: String, dictionary: [String: Any]) {
        guard let title = dictionary["title"] as? String else {
            return nil
        }
        
        self.id = id
        self.title = title
    }
}
