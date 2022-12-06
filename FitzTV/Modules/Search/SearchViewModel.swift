//
//  ShowListViewModel.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 04/12/2022.
//

import Foundation


@MainActor class SearchViewModel: ObservableObject {
    var repo: ShowRepository = ShowRepository()

    @Published var searchText: String = "" {
        didSet {
            if !searchText.isEmpty {
                isSearching = true
                Task { await searchForShow(query: searchText) }
            } else {
                clearShows()
            }
        }
    }

    @Published private(set) var isSearching = false
    @Published var searchResults: [Show] = []
    @Published var thrownError: Error? = nil

    @MainActor func searchForShow(query: String) async {
        do {
            self.searchResults = try await repo.searchShow(word: query)
        } catch {
            thrownError = error
        }
    }

    @MainActor func clearShows() {
        isSearching = false
        searchResults = []
    }

    func clearError() {
        thrownError = nil
    }

}
