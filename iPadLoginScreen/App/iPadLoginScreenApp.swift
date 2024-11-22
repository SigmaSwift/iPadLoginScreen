//
//  iPadLoginScreenApp.swift
//  iPadLoginScreen
//
//  Created by Khachatur Sargsyan on 16.11.24.
//

import SwiftUI

@main
struct iPadLoginScreenApp: App {
    @StateObject private var appRouter: AppRouter = AppRouter(factory: ViewModelFactory())
    
    var body: some Scene {
        WindowGroup {
            RouterView(appRouter: appRouter)
                .environmentObject(appRouter)
        }
    }
}
