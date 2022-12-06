//
//  EndpointTests.swift
//  FitzTVTests
//
//  Created by Fitzgerald Afful on 03/12/2022.
//

import XCTest

final class EndpointTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testEndpointURL() {
        let endpoint = Endpoint.getShows()
        XCTAssertEqual(endpoint.url.absoluteString, "https://api.tvmaze.com/shows?page=1")
    }

    func testMakeForEndpoint() throws {
        let url = URL.makeForEndpoint("shows")
        XCTAssertEqual(url.host(), "api.tvmaze.com")
        XCTAssertEqual(url.absoluteString, "https://api.tvmaze.com/shows")
    }

    func testMakeForEndpointWithSpaces() throws {
        let url = URL.makeForEndpoint("search/shows?q=breaking bad")
        XCTAssertEqual(url.absoluteString, "https://api.tvmaze.com/search/shows?q=breaking%20bad")
    }
}
