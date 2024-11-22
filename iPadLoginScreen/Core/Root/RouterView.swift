//
//  ContentView.swift
//  iPadLoginScreen
//
//  Created by Khachatur Sargsyan on 16.11.24.
//

import SwiftUI

struct RouterView: View {
    @ObservedObject var appRouter: AppRouter
    
    var body: some View {
        NavigationView {
            if let appRoute = appRouter.appRoute {
                switch appRoute {
                case .login(let viewModel):
                    LoginView(viewModel: viewModel)
                case .main(let message):
                    MainScreenView(message: message)
                }
            }
        }
    }
}
