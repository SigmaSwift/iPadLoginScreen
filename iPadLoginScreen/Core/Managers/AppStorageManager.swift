//
//  AppStorageManager.swift
//  iPadLoginScreen
//
//  Created by Khachatur Sargsyan on 23.11.24.
//

protocol AppStorageService {
    func set(username: String)
    func getUsername() -> String?
    func isUserAuthenticated() -> Bool
}

class AppStorageManager: AppStorageService {
    func set(username: String) {}
    func getUsername() -> String? { "Admin" }
    func isUserAuthenticated() -> Bool { false }
}
