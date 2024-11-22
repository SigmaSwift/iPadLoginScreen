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
    case main(_ viewModel: MainViewModel)
    
    func isEqual(_ route: AppRouteLight) -> Bool {
        switch (self, route) {
        case (.login, .login):
            return true
        case (.main, .main):
            return true
        case (_, _):
            return false
        }
    }
}

enum AppRouteLight {
    case login
    case main
}

@MainActor
class AppRouter: ObservableObject {
    @Published var appRoute: AppRoute!
    private var currentRoute: AppRoute!
    
    private let factory: ViewModelFactory
    private let appStorageManager: AppStorageService
    
    init(factory: ViewModelFactory, appStorageManager: AppStorageService) {
        self.factory = factory
        self.appStorageManager = appStorageManager
        
        initialize()
    }
    
    private func initialize() {
        switch appStorageManager.isUserAuthenticated() {
        case (true):
            self.appRoute = createRoute(.main)
        case (false):
            self.appRoute = createRoute(.login)
        }
        
        currentRoute = appRoute
    }
    
    func navigate(_ appRoute: AppRouteLight) {
        guard !currentRoute.isEqual(appRoute) else { return }
        
        switch appRoute {
        case .login:
            self.appRoute = createRoute(.login)
        case .main:
            self.appRoute = createRoute(.main)
        }
    }
    
    private func createAuthViewModel() -> AuthViewModel {
        let viewModel = factory.create(viewModel: .authentication)
        let authViewModel = viewModel as! AuthViewModel
        
        return authViewModel
    }
    
    private func createMainViewModel() -> MainViewModel {
        let viewModel = factory.create(viewModel: .main)
        let mainViewModel = viewModel as! MainViewModel
        
        return mainViewModel
    }
    
    private func createRoute(_ route: AppRouteLight) -> AppRoute {
        let appRout: AppRoute
        switch route {
        case .login:
            let authViewModel = createAuthViewModel()
            appRout = .login(authViewModel)
        case .main:
            let mainViewModel = createMainViewModel()
            appRout = .main(mainViewModel)
        }
        
        currentRoute = appRout
        return appRout
    }
}

protocol ViewModelable {}

@MainActor
class ViewModelFactory {
    enum ViewModel {
        case authentication
        case main
    }
    
    lazy var networkManager = NetworkManager()
    lazy var appStorageManager = AppStorageManager()
        
    func create(viewModel: ViewModel) -> ViewModelable {
        switch viewModel {
        case .authentication:
            return AuthViewModel(networkService: networkManager, appStorageService: appStorageManager)
        case .main:
            return MainViewModel(appStorageService: appStorageManager)
        }
    }
}
