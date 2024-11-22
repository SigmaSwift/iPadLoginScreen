//
//  AuthViewModel.swift
//  iPadLoginScreen
//
//  Created by Khachatur Sargsyan on 16.11.24.
//

import Foundation
import Combine

@MainActor
final class MainViewModel: ObservableObject, ViewModelable {
    private let appStorageService: AppStorageService
    
    init(appStorageService: AppStorageService) {
        self.appStorageService = appStorageService
    }
    
    var username: String {
        appStorageService.getUsername() ?? "Default"
    }
}

@MainActor
final class AuthViewModel: ObservableObject, ViewModelable {
    @Published var viewState: ViewState?
    @Published var login: String = ""
    @Published var password: String = ""
    
    private let networkService: NetworkService
    private let appStorageService: AppStorageService
    
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: NetworkService, appStorageService: AppStorageService) {
        self.networkService = networkService
        self.appStorageService = appStorageService
        
        Publishers.CombineLatest($login, $password)
            .sink { loginText, passwordText in
                print("Login: \(loginText), Password: \(passwordText)")
            }
            .store(in: &cancellables)
    }
    
    func login() async throws {
        do {
            let isSuccessful = try await networkService.login(username: login, password: password)
            if isSuccessful {
                viewState = .loginSuccessful
                appStorageService.set(username: login)
            } else {
                viewState = .loginFailed
            }
        } catch {
            viewState = .loginFailed
        }
    }
}

extension AuthViewModel {
    enum ViewState: Identifiable {
        var id: UUID { UUID() }
        
        case loginSuccessful
        case loginFailed
    }
    
    enum InputType {
        case login(String)
        case password(String)
    }
}
