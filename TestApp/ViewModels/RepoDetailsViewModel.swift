//
//  RepoDetailsViewModel.swift
//  TestApp
//
//  Created by Ivona Ilic on 3/22/25.
//

import Foundation

@MainActor
final class RepoDetailsViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let networkManager: NetworkManager
    
    @Published var repoDetails: Repo?
    @Published var tags: [Tag] = []
    @Published var viewState: ViewState = .idle
    
    // MARK: - Init
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    // MARK: - API
    
    func fetchDetails(user: String, repoName: String) async {
        viewState = .loading
        
        async let detailsResult = fetchRepoDetails(user: user, repoName: repoName)
        async let tagsResult = fetchRepoTags(user: user, repoName: repoName)
        
        await handleResults(detailsResult: detailsResult, tagsResult: tagsResult)
    }
    
    private func fetchRepoDetails(user: String, repoName: String) async -> Result<Repo, NetworkError> {
        do {
            let endpoint = UserRepoEndpoint.repoDetails(repoName: repoName, user: user)
            let details = try await networkManager.request(endpoint, responseType: Repo.self)
            return .success(details)
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(.unknown(error))
        }
    }
    
    private func fetchRepoTags(user: String, repoName: String) async -> Result<[Tag], NetworkError> {
        do {
            let endpoint = UserRepoEndpoint.tags(repoName: repoName, user: user)
            let fetchedTags = try await networkManager.request(endpoint, responseType: [Tag].self)
            return .success(fetchedTags)
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(.unknown(error))
        }
    }
    
    // MARK: - Helpers
    
    private func handleResults(detailsResult: Result<Repo, NetworkError>, tagsResult: Result<[Tag], NetworkError>) async {
        switch (detailsResult, tagsResult) {
            
        case (.success(let details), .success(let fetchedTags)):
            repoDetails = details
            tags = fetchedTags
            viewState = fetchedTags.isEmpty ? .partialLoaded(message: "No tags available.") : .loaded
            
        case (.failure(let detailsError), .success(let fetchedTags)):
            repoDetails = nil
            tags = fetchedTags
            viewState = .partialLoaded(message: detailsError.localizedDescription)
            
        case (.success(let details), .failure(let tagsError)):
            repoDetails = details
            tags = []
            viewState = .partialLoaded(message: tagsError.localizedDescription)
            
        case (.failure(let detailsError), .failure(let tagsError)):
            repoDetails = nil
            tags = []
            viewState = .error(message: "\(detailsError.localizedDescription)\n\(tagsError.localizedDescription)")
        }
    }
}
