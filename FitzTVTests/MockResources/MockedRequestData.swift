//
//  MockedRequestData.swift
//  FitzTVTests
//
//  Created by Fitzgerald Afful on 03/12/2022.
//

import Foundation

public final class MockedRequestData {
    public static let shows: URL = Bundle(for: MockedRequestData.self)
        .url(forResource: "shows", withExtension: "json")!

    public static let search: URL = Bundle(for: MockedRequestData.self)
        .url(forResource: "search", withExtension: "json")!

    public static let episodes: URL = Bundle(for: MockedRequestData.self)
        .url(forResource: "episodes", withExtension: "json")!

    public static let emptyArray: URL = Bundle(for: MockedRequestData.self)
        .url(forResource: "empty", withExtension: "json")!

    public static let malformed: URL = Bundle(for: MockedRequestData.self)
        .url(forResource: "malformed", withExtension: "json")!
}

extension Bundle {
#if !SWIFT_PACKAGE
    static let module = Bundle(for: MockedRequestData.self)
#endif
}

internal extension URL {
    /// Returns a `Data` representation of the current `URL`. Force unwrapping as it's only used for tests.
    var data: Data {
        return try! Data(contentsOf: self)
    }
}
