//
//  ShowListViewModel.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 04/12/2022.
//

import Foundation


class ShowListViewModel: ObservableObject {
    var repo: ShowRepository = ShowRepository()

    @Published private(set) var isLoading = true
    @Published var shows: [Show] = []
    @Published var hasNextPage = false

    @Published private(set) var currentPage: Int = 0

    func loadData() {
        Task {
            await fetchShows()
        }
    }

    @MainActor func fetchShows() async {
        do {
            self.isLoading = true
            let newShows = try await repo.getShows(page: currentPage)
            self.shows.append(contentsOf: newShows)
            hasNextPage = !newShows.isEmpty
            currentPage += 1
            self.isLoading = false
        } catch {
            self.isLoading = false
            error.raiseGlobalAlert()
        }
    }

    func loadMore(currentShow: Show) {
        let thresholdIndex = self.shows.index(self.shows.endIndex, offsetBy: -7)
        if let currentIndex = self.shows.firstIndex(of: currentShow) {
            if currentIndex >= thresholdIndex && self.hasNextPage {
                Task { await fetchShows() }
            }
        }
    }
}
