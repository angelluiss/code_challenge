//
//  NetworkService.swift
//  CoreModule
//
//  Created by Angel Rangel on 14/01/25.
//

import Foundation

/// A concrete implementation of `NetworkServiceProtocol` that performs HTTP requests using `URLSession`
public class NetworkService: NetworkServiceProtocol {
    
    /// The URLSession instance used to perform network requests
    private let session: URLSession
    
    /// Initializes a new instance of `NetworkService`
    /// - Parameter session: The URLSession to be used (default is `.shared`)
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    /// Sends an asynchronous network request to the specified endpoint and decodes the response
    ///
    /// - Parameter endpoint: The endpoint describing the request to be made
    /// - Throws: An error if the request fails or if decoding the response fails
    /// - Returns: A decoded object of type `T` that conforms to `Decodable`
    public func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let urlRequest = try endpoint.urlRequest()
        
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        
        do {
            let decodedResponse = try decoder.decode(T.self, from: data)
            print("✅ Decoded data:", decodedResponse)
            return decodedResponse
        } catch let decodingError as DecodingError {
            print("❌ Decoding error:")
            switch decodingError {
            case .typeMismatch(let type, let context):
                print("- Type mismatch:", type)
                print("  Coding Path:", context.codingPath)
                print("  Debug Description:", context.debugDescription)
            case .valueNotFound(let type, let context):
                print("- Value not found:", type)
                print("  Coding Path:", context.codingPath)
                print("  Debug Description:", context.debugDescription)
            case .keyNotFound(let key, let context):
                print("- Key not found:", key)
                print("  Coding Path:", context.codingPath)
                print("  Debug Description:", context.debugDescription)
            case .dataCorrupted(let context):
                print("- Data corrupted:")
                print("  Coding Path:", context.codingPath)
                print("  Debug Description:", context.debugDescription)
            @unknown default:
                print("- Unknown decoding error:", decodingError)
            }
            throw decodingError
        } catch {
            print("❌ Unexpected error:", error)
            throw error
        }
    }
}
