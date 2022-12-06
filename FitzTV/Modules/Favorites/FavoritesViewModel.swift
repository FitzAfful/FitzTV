//
//  ShowListViewModel.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 04/12/2022.
//

import Foundation


class FavoritesViewModel: ObservableObject {
    var favRepo = FavoritesRepository()

    @Published private(set) var isLoading = true
    @Published var shows: [Show] = []
    @Published var thrownError: Error? = nil

    func loadData() {
        self.isLoading = true
        self.shows = favRepo.getAll()
        self.isLoading = false
    }

    func clearError() {
        thrownError = nil
    }

}
