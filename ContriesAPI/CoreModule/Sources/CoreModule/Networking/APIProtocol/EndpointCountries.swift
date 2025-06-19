//
//  Endpoint.swift
//  CoreModule
//
//  Created by Angel Rangel on 14/01/25.
//

import Foundation

/// Enum representing API endpoints used to fetch country data
public enum Endpoint {
    case allCountries
    case countryDetail(name: String)
    
    /// The path component of the URL for each endpoint
    var path: String {
        switch self {
        case .allCountries:
            return "/all"
        case .countryDetail(let name):
            return "/name/\(name)"
        }
    }
    
    /// Optional query parameters for the URL, depending on the endpoint
    var queryItems: [URLQueryItem]? {
        switch self {
        case .allCountries:
            return [
                URLQueryItem(name: "fields", value: "name,flags,cca2,independent,status,region,latlng,area,translations,capital")
            ]
        default:
            return nil
        }
    }
    
    /// The base URL for the API
    var baseURL: URL {
        return URL(string: "https://restcountries.com/v3.1")!
    }
    
    /// Builds a complete `URLRequest` for the endpoint
    /// - Throws: `URLError.badURL` if the URL components could not be formed
    /// - Returns: A configured `URLRequest` for the endpoint
    public func urlRequest() throws -> URLRequest {
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)!
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
