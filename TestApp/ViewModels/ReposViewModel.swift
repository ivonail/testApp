//
//  ReposViewModel.swift
//  TestApp
//
//  Created by Ivona Ilic on 3/22/25.
//

import Foundation

@MainActor
final class ReposViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let networkManager: NetworkManager
    
    @Published var repos: [Repo] = []
    @Published var viewState: ViewState = .idle
    
    // MARK: - Init
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    // MARK: - API
    
    func fetchRepos(for user: String) async {
        viewState = .loading
        do {
            let endpoint = UserRepoEndpoint.repos(user: user)
            let repos = try await networkManager.request(endpoint, responseType: [Repo].self)
            self.repos = repos
            viewState = repos.isEmpty ? .empty : .loaded
        } catch let error as NetworkError {
            viewState = .error(message: error.localizedDescription)
        } catch {
            viewState = .error(message: error.localizedDescription)
        }
    }
}
