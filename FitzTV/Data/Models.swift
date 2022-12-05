//
//  Show.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 03/12/2022.
//

import Foundation

// MARK: - SearchResult
struct SearchResult: Codable {
    let score: Double
    let show: Show?
    let person: Person?
}

// MARK: - Show
struct Show: Codable, Equatable, Identifiable {
    static func == (lhs: Show, rhs: Show) -> Bool {
        lhs.id == rhs.id
    }

    let id: Int
    let url: String
    let name, type, language: String
    let genres: [String]
    let status: String
    let runtime: Int?
    let averageRuntime: Int?
    let premiered: String?
    let ended: String?
    let officialSite: String?
    let schedule: Schedule
    let rating: Rating
    let weight: Int
    let network: Network?
    let webChannel: WebChannel?
    let dvdCountry: Country?
    let externals: Externals
    let image: ShowImage
    let summary: String
    let updated: Int
    let links: Links

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, averageRuntime, premiered, ended, officialSite, schedule, rating, weight, network, webChannel, dvdCountry, externals, image, summary, updated
        case links = "_links"
    }
}

// MARK: - Episode
struct Episode: Codable {
    let id: Int
    let url: String
    let name: String
    let season, number: Int
    let type, airdate, airtime: String
    let airstamp: String
    let runtime: Int?
    let rating: Rating
    let image: ShowImage
    let summary: String
    let links: Links

    enum CodingKeys: String, CodingKey {
        case id, url, name, season, number, type, airdate, airtime, airstamp, runtime, rating, image, summary
        case links = "_links"
    }
}

// MARK: - Externals
struct Externals: Codable {
    let tvrage: Int?
    let thetvdb: Int?
    let imdb: String?
}

// MARK: - Image
struct ShowImage: Codable {
    let medium, original: String
}

// MARK: - Links
struct Links: Codable {
    let linksSelf, previousEpisode, character, show: Link?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case previousEpisode = "previousepisode"
        case character
        case show
    }
}

// MARK: - Link
struct Link: Codable {
    let href: String
}

// MARK: - Network
struct Network: Codable {
    let id: Int
    let name: String
    let country: Country?
    let officialSite: String?
}

// MARK: - Country
struct Country: Codable {
    let name, code, timezone: String
}

// MARK: - Rating
struct Rating: Codable {
    let average: Double?
}

// MARK: - Schedule
struct Schedule: Codable {
    let time: String
    let days: [String]
}

// MARK: - WebChannel
struct WebChannel: Codable {
    let id: Int
    let name: String
    let country: Country?
    let officialSite: String?
}

// MARK: - Season
struct Season: Codable, Identifiable {
    let id: Int
    var episodes: [Episode] = []
}

// MARK: - Person
struct Person: Codable {
    let id: Int
    let url: String
    let name: String
    let country: Country
    let birthday: String
    let deathday: String?
    let gender: String
    let image: ShowImage
    let updated: Int
    let links: Links

    enum CodingKeys: String, CodingKey {
        case id, url, name, country, birthday, deathday, gender, image, updated
        case links = "_links"
    }
}

// MARK: - Credit
struct Credit: Codable {
    let personSelf, voice: Bool
    let links: Links
    let type: String?

    enum CodingKeys: String, CodingKey {
        case personSelf = "self"
        case voice
        case links = "_links"
        case type
    }
}
