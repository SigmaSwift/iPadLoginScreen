//
//  MainScreenView.swift
//  iPadLoginScreen
//
//  Created by Khachatur Sargsyan on 18.11.24.
//

import SwiftUI

struct MainScreenView: View {
    @ObservedObject var viewModel: MainViewModel
    @EnvironmentObject var appRouter: AppRouter
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Text("Welcome")
                Text("\(viewModel.username) !")
                    .bold()
                    .foregroundStyle(.blue)
            }
            
            Spacer()
            
            Button {
                viewModel.logout()
                appRouter.navigate(.login)
            } label: {
                Text("Logout")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            }
            .frame(width: AppSize.width(ratio: 1.6), height: 48)
            .background(Color(.systemBlue))
            .cornerRadius(10)
        }
    }
}

#Preview {
    MainScreenView(viewModel: .init(appStorageService: AppStorageManager()))
}
