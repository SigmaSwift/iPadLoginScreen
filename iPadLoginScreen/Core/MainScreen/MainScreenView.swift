//
//  MainScreenView.swift
//  iPadLoginScreen
//
//  Created by Khachatur Sargsyan on 18.11.24.
//

import SwiftUI

struct MainScreenView: View {
    let message: String
    
    var body: some View {
        HStack {
            Text("Welcome")
            Text("\(message) !")
                .bold()
                .foregroundStyle(.blue)
        }
    }
}

#Preview {
    MainScreenView(message: "User")
}
