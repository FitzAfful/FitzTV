//
//  Mappables.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 06/12/2022.
//

import Foundation
import RealmSwift

// MARK: - Show
extension Show: Entity {
    func toStorable() -> StorableShow {
        return StorableShow(show: self)
    }
}

// MARK: - Externals
extension Externals: Entity {
    func toStorable() -> StorableExternals {
        return StorableExternals(self)
    }
}

// MARK: - Image
extension ShowImage: Entity {
    func toStorable() -> StorableShowImage {
        return StorableShowImage(self)
    }
}

// MARK: - Links
extension Links: Entity {
    func toStorable() -> StorableLinks {
        return StorableLinks(self)
    }
}

// MARK: - Link
extension Link: Entity {
    func toStorable() -> StorableLink {
        return StorableLink(self)
    }
}

// MARK: - Network
extension Network: Entity {
    func toStorable() -> StorableNetwork {
        return StorableNetwork(self)
    }
}

// MARK: - Country
extension Country: Entity {
    func toStorable() -> StorableCountry {
        return StorableCountry(self)
    }
}

// MARK: - Rating
extension Rating: Entity {
    func toStorable() -> StorableRating {
        return StorableRating(self)
    }
}

// MARK: - Schedule
extension Schedule: Entity {
    func toStorable() -> StorableSchedule {
        return StorableSchedule(self)
    }
}

// MARK: - WebChannel
extension WebChannel: Entity {
    func toStorable() -> StorableWebChannel {
        return StorableWebChannel(self)
    }
}
