//
//  ShowRepository.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 03/12/2022.
//

import Foundation

class ShowRepository {
    let service: APIServiceProtocol = APIService()

    func getShows(page: Int) async throws -> [Show] {
        try await service.getShows(page: page)
    }

    func searchShow(word: String) async throws -> [Show] {
        try await service.search(query: word).compactMap { $0.show }
    }

    func searchPerson(word: String) async throws -> [Person] {
        try await service.search(query: word).compactMap { $0.person }
    }

    func getEpisodes(showId: Int) async throws -> [Episode] {
        try await service.getEpisodes(showId: showId)
    }

    func getShow(id: Int) async throws -> Show {
        try await service.getShow(id: id)
    }

    func getPerson(id: Int) async throws -> Person {
        try await service.getPerson(id: id)
    }

    func getPersonCastCredits(id: Int) async throws -> [Credit] {
        try await service.getPersonCastCredits(id: id)
    }

    func getPersonGuestCastCredits(id: Int) async throws -> [Credit] {
        try await service.getPersonGuestCastCredits(id: id)
    }

    func getPersonCrewCastCredits(id: Int) async throws -> [Credit] {
        try await service.getPersonCrewCastCredits(id: id)
    }
}
