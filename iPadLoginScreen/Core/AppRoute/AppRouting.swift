//
//  AppRouting.swift
//  iPadLoginScreen
//
//  Created by Khachatur Sargsyan on 21.11.24.
//

import Foundation
import SwiftUI

enum AppRoute {
    case login(_ viewModel: AuthViewModel)
    case main(_ message: String)
}

enum AppRouteLight {
    case login
    case main(message: String?)
}

@MainActor
class AppRouter: ObservableObject {
    @Published var appRoute: AppRoute?
    private var factory: ViewModelFactory
    
    init(factory: ViewModelFactory) {
        self.factory = factory
        
        initialize()
    }
    
    func initialize() {
        if AppStorage.isUserAuthenticated {
            let message = AppStorage.username
            appRoute = .main(message)
        } else {
            let authViewModel = createAuthViewModel()
            appRoute = .login(authViewModel)
        }
    }
    
    private func createAuthViewModel() -> AuthViewModel {
        let viewModel = factory.create(viewModel: .authentication)
        let authViewModel = viewModel as! AuthViewModel
        
        return authViewModel
    }
 
    func navigate(_ appRoute: AppRouteLight) {
        switch appRoute {
        case .login:
            let authViewModel = createAuthViewModel()
            self.appRoute = .login(authViewModel)
        case .main(let message):
            if let message {
                self.appRoute = .main(message)
            } else {
                self.appRoute = .main(AppStorage.username)
            }
        }
    }
}

protocol ViewModelable {}

@MainActor
class ViewModelFactory {
    enum ViewModel {
        case authentication
    }
        
    func create(viewModel: ViewModel) -> ViewModelable {
        switch viewModel {
        case .authentication:
            let networkService = NetworkManager()
            return AuthViewModel(networkService: networkService)
        }
    }
}

struct AppStorage {
    static var username: String = "Admin"
    static var isUserAuthenticated: Bool = true
}
