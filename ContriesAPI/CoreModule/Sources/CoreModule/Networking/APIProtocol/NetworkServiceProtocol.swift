//
//  NetworkServiceProtocol.swift
//  CoreModule
//
//  Created by Angel Rangel on 14/01/25.
//

import Foundation

/// A protocol that defines a generic network service for making API requests
public protocol NetworkServiceProtocol {
    /// Sends a network request to the given endpoint and decodes the response into a specified type
    ///
    /// - Parameter endpoint: The endpoint to which the request will be sent
    /// - Throws: An error if the network request fails or the response cannot be decoded
    /// - Returns: A decoded object of type `T` that conforms to `Decodable`
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}
