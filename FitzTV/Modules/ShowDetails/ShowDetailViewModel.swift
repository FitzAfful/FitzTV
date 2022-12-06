//
//  ShowDetailViewModel.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 04/12/2022.
//

import Foundation
import Combine

class ShowDetailViewModel: ObservableObject {
    private var repo = ShowRepository()
    private var favRepo = FavoritesRepository()

    @Published private(set) var isLoading = true
    @Published var show: Show
    @Published var seasons: [Season] = []
    @Published var thrownError: Error? = nil
    @Published var selectedEpisode: Episode?
    @Published var isFavorited: Bool = false


    init(show: Show) {
        self.show = show
        self.isFavorited = favRepo.exists(item: show)
    }

    func loadData() {
        Task {
            await fetchEpisdoes()
        }
    }

    @MainActor func fetchEpisdoes() async {
        do {
            self.isLoading = true
            let newEpisodes = try await repo.getEpisodes(showId: show.id)
            self.seasons = sortEpisodes(newEpisodes)
            self.isLoading = false
        } catch {
            self.isLoading = false
            thrownError = error
        }
    }

    func sortEpisodes(_ episodes: [Episode]) -> [Season] {
        var seasons: [Season] = []
        for episode in episodes {
            if seasons.map({ $0.id }).contains(episode.season) {
                if let index = seasons.firstIndex(where: { $0.id == episode.season }) {
                    seasons[index].episodes.append(episode)
                }
            } else {
                seasons.append(Season(id: episode.season, episodes: [episode]))
            }
        }
        return seasons
    }

    func getSubTitle() -> String {
        var sub = ""
        if let rating = show.rating?.average {
            sub = String(format: "%.1f", rating) + " • "
        }

        if let airtime = show.runtime {
            sub.append("\(airtime) mins • ")
        }

        if let network = show.network {
            sub.append(network.name)
        }

        return sub
    }

    func getRunningDate() -> String {
        var runningDate = ""
        if let premiered = show.premiered {
            runningDate.append(String(premiered.prefix(4)))
            runningDate.append(" - ")
            if let ended = show.ended {
                runningDate.append(String(ended.prefix(4)))
            } else {
                runningDate.append("Present")
            }
        }
        return runningDate
    }

    func addToFavorites() {
        do {
            try favRepo.insert(item: self.show)
            self.isFavorited = true
        } catch {
            thrownError = error
        }
    }

    func removeFromFavorites() {
        do {
            try favRepo.delete(item: self.show)
            self.isFavorited = false
        } catch {
            thrownError = error
        }
    }

    func clearError() {
        thrownError = nil
    }

}
