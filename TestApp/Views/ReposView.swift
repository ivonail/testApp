//
//  ReposView.swift
//  TestApp
//
//  Created by Ivona Ilic on 3/21/25.
//

import SwiftUI

struct ReposView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = ReposViewModel()
    @EnvironmentObject private var router: AppRouter
    
    // MARK: - View
    
    var body: some View {
        VStack {
            HStack {
                Text(Constants.Strings.appTitle)
                    .foregroundStyle(Color.accent)
                    .font(.title2)
                Spacer()
            }
            .padding([.horizontal, .top])
            
            switch viewModel.viewState {
            case .loading:
                ProgressView("Loading repos...")
                
            case .loaded, .partialLoaded:
                List(viewModel.repos) { repo in
                    Button {
                        router.push(.repoDetails)
                    } label: {
                        HStack {
                            Text(repo.name ?? "")
                                .foregroundStyle(Color.accent)
                                .font(.title3)
                            Spacer()
                            VStack(spacing: Constants.Layout.listSpacing) {
                                Image(systemName: "folder")
                                    .foregroundStyle(Color.accent)
                                Text("\(repo.openIssuesCount ?? 0)")
                                    .foregroundStyle(Color.accent)
                                    .font(.caption)
                            }
                            .frame(width: Constants.Layout.folderWidth)
                            
                        }
                        .padding(.vertical, Constants.Layout.rowPadding)
                    }
                }
                .scrollContentBackground(.hidden)
                
            case .error(let message):
                Text("Error: \(message)")
                    .foregroundStyle(.red)
                
            case .idle:
                Text("Welcome!")
            case .empty:
                Text("No data")
            }
        }
        .task {
            await viewModel.fetchRepos(for: Constants.Strings.userName)
        }
    }
    
}

#Preview {
    ReposView()
}
