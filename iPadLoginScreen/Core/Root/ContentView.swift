//
//  ContentView.swift
//  iPadLoginScreen
//
//  Created by Khachatur Sargsyan on 16.11.24.
//

import SwiftUI

@MainActor
struct ContentView: View {
    @StateObject var viewModel: AuthViewModel = .init(networkService: NetworkManager())
    
    var body: some View {
        LoginView(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}
