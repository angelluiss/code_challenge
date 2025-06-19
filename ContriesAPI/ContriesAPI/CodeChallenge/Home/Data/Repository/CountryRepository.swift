//
//  CountryRepository.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 27/05/25.
//

import CoreModule

/// A concrete implementation of `CountriesRepositoryProtocol` that handles
/// data retrieval related to countries using a network service.
public class CountryRepository: CountriesRepositoryProtocol {
    
    /// The service responsible for executing network requests
    private let networkService: NetworkServiceProtocol
    
    /// Initializes a new instance of `CountryRepository`
    ///
    /// - Parameter networkService: The network service used to perform API requests
    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    /// Fetches a list of all countries with basic flag and name information
    ///
    /// - Returns: An array of `FlagDTO` representing the countries
    /// - Throws: An error if the network request or decoding fails
    public func fetchAllCountries() async throws -> [FlagDTO] {
        return try await networkService.request(Endpoint.allCountries)
    }
    
    /// Fetches detailed information for a specific country
    ///
    /// - Parameter name: The name of the country to fetch
    /// - Returns: An array of `CountryDetailElement` with detailed country information
    /// - Throws: An error if the network request or decoding fails
    public func fetchCountryDetail(name: String) async throws -> [CountryDetailElement] {
        return try await networkService.request(Endpoint.countryDetail(name: name))
    }
}
