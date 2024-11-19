//
//  LoginView.swift
//  iPadLoginScreen
//
//  Created by Khachatur Sargsyan on 16.11.24.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
        
    @ObservedObject var viewModel: AuthViewModel
    
    @State private var showAlert: Bool = false
    @State private var needToNavigate: Bool = false
    
    private var isIPad: Bool {
        switch (horizontalSizeClass, verticalSizeClass) {
        case (.regular, .regular):
            return true
        case (_, _):
            return false
        }
    }
        
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                    .frame(height: 150)
            
                VStack(spacing: 16) {
                    InputView(
                        text: $viewModel.login,
                        title: "Username",
                        placeholder: "example@gmail.com"
                    )
                    
                    InputView(
                        text: $viewModel.password,
                        title: "Password",
                        placeholder: "Enter your password",
                        isSecureField: true
                    )
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Button {
                        Task {
                            try await viewModel.login()
                        }
                    } label: {
                        Text("Login")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    }
                    .frame(width: isIPad ? AppSize.width(ratio: 2) : AppSize.width(ratio: 1.6), height: 48)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
                }
                .frame(width: isIPad ? AppSize.width(ratio: 1.5) : AppSize.width(ratio: 1.2))
                
                Spacer()
            }
            .onChange(of: viewModel.viewState) { _, state in
                guard let state else { return }
                
                switch state {
                case .loginSuccessful:
                    needToNavigate = true
                case .loginFailed:
                    showAlert = true
                }
            }
            .navigationDestination(isPresented: $needToNavigate) {
                MainScreenView(message: viewModel.login)
                    .navigationBarBackButtonHidden()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Alert"),
                    message: Text("Login failed!"),
                    dismissButton: .default(Text("Ok"))
                )
            }
        }
    }
}

#Preview {
    LoginView(viewModel: .init(networkService: NetworkManager()))
}

// It should be moved to a separate file
struct AppSize {
    static var screenWidth: CGFloat { UIScreen.main.bounds.width }
    
    static func width(ratio: CGFloat) -> CGFloat {
        CGFloat(Int(screenWidth / ratio))
    }
}
