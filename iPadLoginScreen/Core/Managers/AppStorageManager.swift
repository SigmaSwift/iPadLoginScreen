//
//  AppStorageManager.swift
//  iPadLoginScreen
//
//  Created by Khachatur Sargsyan on 23.11.24.
//

import Foundation

protocol AppStorageService {
    func set(username: String)
    func getUsername() -> String?
    func isUserAuthenticated() -> Bool
    func clear()
}

class AppStorageManager: AppStorageService {
    private var userDefaults: UserDefaults = UserDefaults.standard
    
    func set(username: String) {
        userDefaults.setValue(username, forKey: "username_key")
    }
    
    func getUsername() -> String? {
        userDefaults.value(forKey: "username_key") as? String
    }
    
    func isUserAuthenticated() -> Bool { getUsername() != nil }
    
    func clear() {
        userDefaults.setValue(nil, forKey: "username_key")
    }
}
