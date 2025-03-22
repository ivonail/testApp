//
//  RepoDetailsView.swift
//  TestApp
//
//  Created by Ivona Ilic on 3/21/25.
//

import SwiftUI

struct RepoDetailsView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = RepoDetailsViewModel()
    @EnvironmentObject private var router: AppRouter
    
    let repoName: String
    
    // MARK: - View
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constants.Layout.padding) {
                switch viewModel.viewState {
                case .loading:
                    ProgressView("Loading details...")
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                case .loaded, .partialLoaded:
                    headerSection
                    repoInfoSection
                    Divider()
                    tagsSection
                    
                case .error(let message):
                    Text("Error: \(message)")
                        .foregroundColor(.red)
                        .padding()
                    
                case .empty:
                    Text("No details found.")
                        .foregroundColor(.secondary)
                        .padding()
                    
                case .idle:
                    EmptyView()
                }
            }
            .padding(Constants.Layout.padding)
        }
        .task {
            await viewModel.fetchDetails(user: Constants.Strings.userName, repoName: repoName)
        }
    }
    
    // MARK: - Subviews
    
    private var headerSection: some View {
        HStack {
            Spacer()
            VStack(spacing: Constants.Layout.listSpacing) {
                AsyncImage(url: URL(string: viewModel.repoDetails?.owner?.avatarUrl ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: Constants.Layout.imageSize, height: Constants.Layout.imageSize)
                        .clipShape(Circle())
                } placeholder: {
                    Circle().fill(Color.gray.opacity(Constants.Layout.placeholderOpacity))
                        .frame(width: Constants.Layout.imageSize, height: Constants.Layout.imageSize)
                }
                
                Text("@\(viewModel.repoDetails?.owner?.login ?? "")")
                    .font(.title3)
                    .foregroundStyle(Color.accent)
                
                Text("Repo: \(viewModel.repoDetails?.name ?? "")")
                    .font(.title2)
                    .bold()
                
            }
            Spacer()
        }
    }
    
    private var repoInfoSection: some View {
        HStack(spacing: Constants.Layout.padding) {
            Spacer()
            Text("Forks: \(viewModel.repoDetails?.forksCount ?? 0)")
            Text("Watchers: \(viewModel.repoDetails?.watchersCount ?? 0)")
            Spacer()
        }
        .foregroundStyle(Color.accent)
        .font(.subheadline)
    }
    
    private var tagsSection: some View {
        VStack(alignment: .leading, spacing: Constants.Layout.listSpacing) {
            Text("Tags")
                .font(.headline)
            if viewModel.tags.isEmpty {
                Text("No tags available")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding()
            } else {
                
                ForEach(viewModel.tags, id: \.name) { tag in
                    VStack(alignment: .leading, spacing: Constants.Layout.listSpacing) {
                        Text(tag.name ?? "")
                            .font(.subheadline)
                            .foregroundStyle(.accent)
                            .bold()
                        Text("\(tag.commit?.sha ?? "")")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    .padding(.vertical, Constants.Layout.listSpacing)
                }
            }
        }
        .padding(.leading, Constants.Layout.tagsPadding)
    }
}

#Preview {
    RepoDetailsView(repoName: "linguist")
}
