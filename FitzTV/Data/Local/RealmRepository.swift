//
//  RepositoryProtocol.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 06/12/2022.
//

import Foundation

protocol RealmRepository {
    associatedtype EntityObject: Entity

    func getAll(where predicate: NSPredicate?) -> [EntityObject]
    func insert(item: EntityObject) throws
    func update(item: EntityObject) throws
    func delete(item: EntityObject) throws
}

extension RealmRepository {
    func getAll() -> [EntityObject] {
        return getAll(where: nil)
    }
}
