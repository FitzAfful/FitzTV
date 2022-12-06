//
//  ShowRepository.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 03/12/2022.
//

import Foundation
import RealmSwift

class FavoritesRepository: RealmRepository {
    private let realm: Realm

    init() {
        realm = try! Realm()
    }

    func getAll(where predicate: NSPredicate?) -> [Show] {
        var objects = realm.objects(StorableShow.self)

        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        return objects.compactMap{ ($0).model }
    }

    func insert(item: Show) throws {
        try realm.write {
            realm.add(item.toStorable())
        }
    }

    func update(item: Show) throws {
        try realm.write {
            realm.add(item.toStorable(), update: .modified)
        }
    }

    func delete(item: Show) throws {
        try realm.write {
            if let storable = (realm.objects(StorableShow.self).where { $0.id == item.id }).first {
                realm.delete(storable)
            }
        }
    }

    func exists(item: Show) -> Bool {
        let predicate = NSPredicate(format: "id == %@", NSNumber(value: item.id))
        return !getAll(where: predicate).isEmpty
    }
}
