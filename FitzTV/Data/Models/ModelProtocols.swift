//
//  Protocols.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 06/12/2022.
//

import Foundation

public protocol Entity {
    associatedtype StoreType: Storable

    func toStorable() -> StoreType
}

public protocol Storable {
    associatedtype EntityObject: Entity

    var model: EntityObject { get }
    //var uuid: String { get }
}
