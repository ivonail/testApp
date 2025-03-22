//
//  AppRouter.swift
//  TestApp
//
//  Created by Ivona Ilic on 3/21/25.
//

import SwiftUI

enum Screen: Hashable {
    case repos
    case repoDetails
}


final class AppRouter: ObservableObject {
    
    @Published var path = NavigationPath()
    
    var startView: some View {
        ReposView()
    }
    
    @ViewBuilder
    func view(for screen: Screen) -> some View {
        switch screen {
        case .repos:
            ReposView()
        case .repoDetails:
            RepoDetailsView()
        }
    }
    
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func resetToRoot() {
        path = NavigationPath()
    }
}
