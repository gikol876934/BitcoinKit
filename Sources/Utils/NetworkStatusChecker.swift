//
//  NetworkStatusChecker.swift
//  BitcoinKit
//
//  Created by Marta on 18/10/2025.
//  Distributed under the MIT License.
//

import Foundation

/// Educational example for GitHub workflow practice.
/// Checks basic reachability to a Bitcoin node endpoint.
/// Not for production use.
public final class NetworkStatusChecker {

    public enum NetworkError: Error {
        case invalidURL
        case noResponse
        case unreachable
    }

    public init() {}

    /// Attempts to ping the given Bitcoin node (or API endpoint) with a simple request.
    /// - Parameter endpoint: Node URL (e.g. "https://blockchain.info")
    /// - Returns: Boolean indicating connectivity.
    @discardableResult
    public func isNodeReachable(endpoint: String) async throws -> Bool {
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        request.timeoutInterval = 5

        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.noResponse
        }

        if (200...399).contains(httpResponse.statusCode) {
            return true
        } else {
            throw NetworkError.unreachable
        }
    }
}
