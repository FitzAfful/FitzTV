//
//  APIService.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 04/12/2022.
//

import Foundation

enum Endpoint {
    case getShows(Int? = nil)
    case getEpisodes(showId: Int)
    case search(String)
    case getShow(Int)
    case getPerson(Int)
    case getPersonCastCredits(Int)
    case getPersonGuestCastCredits(Int)
    case getPersonCrewCastCredits(Int)

    var url: URL {
        switch self {
        case .getShows(let page):
            return .makeForEndpoint("shows?page=\(page ?? 1)")
        case .getEpisodes(let showId):
            return .makeForEndpoint("shows/\(showId)/episodes")
        case .search(let word):
            return .makeForEndpoint("search/shows?q=\(word)")
        case .getShow(let id):
            return .makeForEndpoint("shows/\(id)")
        case .getPerson(let id):
            return .makeForEndpoint("people/\(id)")
        case .getPersonCastCredits(let id):
            return .makeForEndpoint("people/\(id)/castcredits")
        case .getPersonGuestCastCredits(let id):
            return .makeForEndpoint("people/\(id)/guestcastcredits")
        case .getPersonCrewCastCredits(let id):
            return .makeForEndpoint("people/\(id)/crewcredits")
        }
    }
}

protocol APIServiceProtocol {
    func getShows(page: Int) async throws -> [Show]
    func search(query: String) async throws -> [SearchResult]
    func getEpisodes(showId: Int) async throws -> [Episode]
    func getShow(id: Int) async throws -> Show

    func getPerson(id: Int) async throws -> Person
    func getPersonCrewCastCredits(id: Int) async throws -> [Credit]
    func getPersonCastCredits(id: Int) async throws -> [Credit]
    func getPersonGuestCastCredits(id: Int) async throws -> [Credit]

}

class APIService: APIServiceProtocol {
    var urlSession = URLSession.shared

    func getShows(page: Int) async throws -> [Show] {
        return try await urlSession.request(for: .getShows(page))
    }

    func search(query: String) async throws -> [SearchResult] {
        return try await urlSession.request(for: .search(query))
    }

    func getEpisodes(showId: Int) async throws -> [Episode] {
        return try await urlSession.request(for: .getEpisodes(showId: showId))
    }

    func getShow(id: Int) async throws -> Show {
        return try await urlSession.request(for: .getShow(id))
    }

    func getPerson(id: Int) async throws -> Person {
        return try await urlSession.request(for: .getPerson(id))
    }

    func getPersonCrewCastCredits(id: Int) async throws -> [Credit] {
        return try await urlSession.request(for: .getPersonCrewCastCredits(id))
    }

    func getPersonCastCredits(id: Int) async throws -> [Credit] {
        return try await urlSession.request(for: .getPersonCastCredits(id))
    }

    func getPersonGuestCastCredits(id: Int) async throws -> [Credit] {
        return try await urlSession.request(for: .getPersonGuestCastCredits(id))
    }
}
