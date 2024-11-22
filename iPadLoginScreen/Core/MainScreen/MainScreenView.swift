//
//  MainScreenView.swift
//  iPadLoginScreen
//
//  Created by Khachatur Sargsyan on 18.11.24.
//

import SwiftUI

struct MainScreenView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        HStack {
            Text("Welcome")
            Text("\(viewModel.username) !")
                .bold()
                .foregroundStyle(.blue)
        }
    }
}

#Preview {
    MainScreenView(viewModel: .init(appStorageService: AppStorageManager()))
}
