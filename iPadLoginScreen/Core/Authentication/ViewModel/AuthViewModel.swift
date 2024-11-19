//
//  AuthViewModel.swift
//  iPadLoginScreen
//
//  Created by Khachatur Sargsyan on 16.11.24.
//

import Foundation
import Combine

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var viewState: ViewState?
    @Published var login: String = ""
    @Published var password: String = ""
    
    private let networkService: NetworkService
    
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        
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
