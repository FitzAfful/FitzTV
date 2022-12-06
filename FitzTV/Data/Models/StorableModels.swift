//
//  Show.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 03/12/2022.
//

import Foundation
import RealmSwift

// MARK: - Show
class StorableShow: Object, ObjectKeyIdentifiable, Storable {
    @Persisted var id: Int
    @Persisted var url: String
    @Persisted var name: String
    @Persisted var type: String
    @Persisted var language: String
    @Persisted var genres: List<String>
    @Persisted var status: String
    @Persisted var runtime: Int?
    @Persisted var averageRuntime: Int?
    @Persisted var premiered: String?
    @Persisted var ended: String?
    @Persisted var officialSite: String?
    @Persisted var schedule: StorableSchedule?
    @Persisted var rating: StorableRating?
    @Persisted var weight: Int
    @Persisted var network: StorableNetwork?
    @Persisted var webChannel: StorableWebChannel?
    @Persisted var dvdCountry: StorableCountry?
    @Persisted var externals: StorableExternals?
    @Persisted var image: StorableShowImage?
    @Persisted var summary: String
    @Persisted var updated: Int
    @Persisted var links: StorableLinks?

    convenience init(show: Show) {
        self.init()
        self.id = show.id
        self.url = show.url
        self.name = show.name
        self.type = show.type
        self.language = show.language

        let list = List<String>()
        list.append(objectsIn: show.genres)
        self.genres = list
        self.status = show.status
        self.runtime = show.runtime
        self.averageRuntime = show.averageRuntime
        self.averageRuntime = show.averageRuntime
        self.premiered = show.premiered
        self.ended = show.ended
        self.officialSite = show.officialSite
        if let schedule = show.schedule {
            self.schedule = StorableSchedule(schedule)
        }
        if let rating = show.rating {
            self.rating = StorableRating(rating)
        }
        self.weight = show.weight
        if let network = show.network {
            self.network = StorableNetwork(network)
        }
        if let webChannel = show.webChannel {
            self.webChannel = StorableWebChannel(webChannel)
        }
        if let dvdCountry = show.dvdCountry {
            self.dvdCountry = StorableCountry(dvdCountry)
        }
        if let externals = show.externals {
            self.externals = StorableExternals(externals)
        }
        if let image = show.image {
            self.image = StorableShowImage(image)
        }
        self.summary = show.summary
        self.updated = show.updated
        if let links = show.links {
            self.links = StorableLinks(links)
        }
    }

    var model: Show {
        return Show(id: id, url: url, name: name, type: type, language: language, genres: genres.map { $0 }, status: status, runtime: runtime, averageRuntime: averageRuntime, premiered: premiered, ended: ended, officialSite: officialSite, schedule: schedule?.model, rating: rating?.model, weight: weight, network: network?.model, webChannel: webChannel?.model, dvdCountry: dvdCountry?.model, externals: externals?.model, image: image?.model, summary: summary, updated: updated, links: links?.model)
    }
}

// MARK: - Externals
class StorableExternals: Object, ObjectKeyIdentifiable, Storable {
    @Persisted var tvrage: Int?
    @Persisted var thetvdb: Int?
    @Persisted var imdb: String?

    convenience init(_ externals: Externals) {
        self.init()
        self.tvrage = externals.tvrage
        self.thetvdb = externals.thetvdb
        self.imdb = externals.imdb
    }

    var model: Externals {
        return Externals(tvrage: tvrage, thetvdb: thetvdb, imdb: imdb)
    }
}

// MARK: - Image
class StorableShowImage: Object, ObjectKeyIdentifiable, Storable {
    @Persisted var medium: String
    @Persisted var original: String

    convenience init(_ showImage: ShowImage) {
        self.init()
        self.medium = showImage.medium
        self.original = showImage.original
    }

    var model: ShowImage {
        return ShowImage(medium: medium, original: original)
    }
}

// MARK: - Links
class StorableLinks: Object, ObjectKeyIdentifiable, Storable {
    @Persisted var linksSelf: StorableLink?
    @Persisted var previousEpisode: StorableLink?
    @Persisted var character: StorableLink?
    @Persisted var show: StorableLink?

    convenience init(_ links: Links) {
        self.init()
        if let linksSelf = links.linksSelf {
            self.linksSelf = StorableLink(linksSelf)
        }
        if let previousEpisode = links.previousEpisode {
            self.previousEpisode = StorableLink(previousEpisode)
        }
        if let character = links.character {
            self.character = StorableLink(character)
        }
        if let show = links.show {
            self.show = StorableLink(show)
        }
    }

    var model: Links {
        return Links(linksSelf: linksSelf?.model, previousEpisode: previousEpisode?.model, character: character?.model, show: show?.model)
    }
}

// MARK: - Link
class StorableLink: Object, ObjectKeyIdentifiable, Storable {
    @Persisted var href: String

    convenience init(_ link: Link) {
        self.init()
        self.href = link.href
    }

    var model: Link {
        return Link(href: href)
    }
}

// MARK: - Network
class StorableNetwork: Object, ObjectKeyIdentifiable, Storable {
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var country: StorableCountry?
    @Persisted var officialSite: String?

    convenience init(_ network: Network) {
        self.init()
        self.id = network.id
        self.name = network.name
        if let country = network.country {
            self.country = StorableCountry(country)
        }
        self.officialSite = network.officialSite
    }

    var model: Network {
        return Network(id: id, name: name, country: country?.model, officialSite: officialSite)
    }
}

// MARK: - Country
class StorableCountry: Object, ObjectKeyIdentifiable, Storable {
    @Persisted var name: String
    @Persisted var code: String
    @Persisted var timezone: String

    convenience init(_ country: Country) {
        self.init()
        self.name = country.name
        self.code = country.code
        self.timezone = country.timezone
    }

    var model: Country {
        return Country(name: name, code: code, timezone: timezone)
    }
}

// MARK: - Rating
class StorableRating: Object, ObjectKeyIdentifiable, Storable {
    @Persisted var average: Double?

    convenience init(_ rating: Rating) {
        self.init()
        self.average = rating.average
    }

    var model: Rating {
        return Rating(average: average)
    }
}

// MARK: - Schedule
class StorableSchedule: Object, ObjectKeyIdentifiable, Storable {
    @Persisted var time: String
    @Persisted var days: List<String>

    convenience init(_ schedule: Schedule) {
        self.init()
        self.time = schedule.time
        let list = List<String>()
        list.append(objectsIn: schedule.days)
        self.days = list
    }

    var model: Schedule {
        return Schedule(time: time, days: days.map { $0 })
    }
}

// MARK: - WebChannel
class StorableWebChannel: Object, ObjectKeyIdentifiable, Storable {
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var country: StorableCountry?
    @Persisted var officialSite: String?

    convenience init(_ webExternals: WebChannel) {
        self.init()
        self.id = webExternals.id
        self.name = webExternals.name
        if let country = webExternals.country {
            self.country = StorableCountry(country)
        }
        self.officialSite = webExternals.officialSite
    }

    var model: WebChannel {
        return WebChannel(id: id, name: name, country: country?.model, officialSite: officialSite)
    }
}
