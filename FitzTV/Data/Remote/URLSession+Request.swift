//
//  Endpoints.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 03/12/2022.
//

import Foundation
import Combine

extension URL {
    static func makeForEndpoint(_ endpoint: String) -> URL {
        return URL(string: "https://api.tvmaze.com/\(endpoint)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
    }
}

extension URLSession {

    func request<D: Decodable>(for endpoint: Endpoint) async throws -> D {
        // Execute the request in the background
        let task = Task.detached(priority: .background) {
            assert(!Thread.isMainThread)
            let request = URLRequest(url: endpoint.url)
            let (data, response) = try await URLSession.shared.data(for: request)

            let httpResponse = (response as? HTTPURLResponse)
            switch httpResponse?.statusCode {
            case 200, 201, 204:
                return try JSONDecoder().decode(D.self, from: data)
            case 400:
                throw URLError(.badURL)
            case 404:
                throw URLError(.resourceUnavailable)
            case 401:
                throw URLError(.userAuthenticationRequired)
            default:
                throw URLError(.badServerResponse)
            }
        }

        // Return the item on the main thread
        let response = try await task.value
        return await MainActor.run { response }
    }
}


