//
//  TestAppApp.swift
//  TestApp
//
//  Created by Ivona Ilic on 3/21/25.
//

import SwiftUI

@main
struct TestApp: App {
    
    @StateObject private var router = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                router.startView
                    .navigationDestination(for: Screen.self) { screen in
                        router.view(for: screen)
                    }
            }
            .environmentObject(router)
        }
    }
}
