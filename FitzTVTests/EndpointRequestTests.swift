//
//  EndpointRequestTests.swift
//  FitzTVTests
//
//  Created by Fitzgerald Afful on 03/12/2022.
//

import XCTest
import Mocker

final class EndpointRequestTests: XCTestCase {

    override func setUpWithError() throws {
        Mock(url: Endpoint.getShows().url,
             dataType: .json,
             statusCode: 200,
             data: [.get: try Data(contentsOf: MockedRequestData.shows)]
        ).register()

        Mock(url: Endpoint.search("girls").url,
             dataType: .json,
             statusCode: 200,
             data: [.get: try Data(contentsOf: MockedRequestData.search)]
        ).register()

        Mock(url: Endpoint.getEpisodes(showId: 1).url,
             dataType: .json,
             statusCode: 200,
             data: [.get: try Data(contentsOf: MockedRequestData.episodes)]
        ).register()

        // malformed
        Mock(url: Endpoint.getShows().url,
            dataType: .json,
            statusCode: 200,
            data: [.get: try Data(contentsOf: MockedRequestData.malformed)]
        ).register()

        // empty
        Mock(url: Endpoint.getShows().url,
            dataType: .json,
            statusCode: 200,
            data: [.get: try Data(contentsOf: MockedRequestData.malformed)]
        ).register()
    }


}
