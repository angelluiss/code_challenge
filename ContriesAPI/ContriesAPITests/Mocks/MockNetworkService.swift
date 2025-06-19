//
//  MockNetworkService.swift
//  ContriesAPITests
//
//  Created by Angel Gabriel Rangel Pinero on 28/05/25.
//

import Foundation
import CoreModule
@testable import ContriesAPI

/// A mock implementation of `NetworkServiceProtocol` used for testing.
/// Simulates network calls and allows injection of predefined responses or errors.
class MockNetworkService: NetworkServiceProtocol {
    
    /// Captures the most recently requested endpoint for inspection in tests.
    var requestedEndpoint: Endpoint?
    
    /// The mock response to return when `request<T>` is called.
    var mockResponse: Any?
    
    /// When set to `true`, the service will throw an error instead of returning a response.
    var shouldThrowError = false

    /// Simulates a network request.
    /// - Parameters:
    ///   - endpoint: The endpoint to be requested.
    /// - Returns: A mock response of type `T` or throws an error.
    func request<T>(_ endpoint: Endpoint) async throws -> T where T : Decodable {
        self.requestedEndpoint = endpoint

        if shouldThrowError {
            // Simulate a network failure.
            throw URLError(.badServerResponse)
        }

        // Attempt to cast the mock response to the expected type.
        guard let response = mockResponse as? T else {
            // Simulate decoding failure.
            throw URLError(.cannotDecodeContentData)
        }

        return response
    }
}
