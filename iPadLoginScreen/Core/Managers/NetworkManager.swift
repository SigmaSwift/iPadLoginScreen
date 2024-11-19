//
//  NetworkManager.swift
//  iPadLoginScreen
//
//  Created by Khachatur Sargsyan on 16.11.24.
//

protocol NetworkService {
    func login(username: String, password: String) async throws -> Bool
}

class NetworkManager: NetworkService {
    func login(username: String, password: String) async throws -> Bool {
        do {
            try await Task.sleep(for: .seconds(0.5))
            
            if username == "admin", password == "45xz" {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}
