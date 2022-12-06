//
//  EpisodeDetailViewModel.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 04/12/2022.
//

import Foundation

class EpisodeDetailViewModel: ObservableObject {
    @Published var episode: Episode

    init(episode: Episode) {
        self.episode = episode
    }
}
