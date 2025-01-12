//
//  Shared.swift
//  habit-tracker
//
//  Created by Salah Khaled on 12/01/2025.
//


import Foundation

public struct Keys {
    static let username = "username"
}


class Shared {
    
    private static let userDefaults = UserDefaults.standard
    
    static var username: String? {
        set {
            userDefaults.set(newValue, forKey: Keys.username)
        } get {
            return userDefaults.string(forKey: Keys.username)
        }
    }
    
}
