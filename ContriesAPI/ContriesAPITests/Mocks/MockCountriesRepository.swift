//
//  MockCountriesRepository.swift
//  ContriesAPITests
//
//  Created by Angel Gabriel Rangel Pinero on 30/05/25.
//

import Foundation
@testable import ContriesAPI

/// A mock implementation of `CountriesRepositoryProtocol`
/// used to simulate network responses during unit testing.
class MockCountriesRepository: CountriesRepositoryProtocol {
    
    /// Determines whether the mock should throw an error when methods are called.
    var shouldThrowError = false

    /// Simulates fetching all countries.
    ///
    /// - Throws: `URLError(.badServerResponse)` if `shouldThrowError` is `true`
    /// - Returns: An array containing a single mock `FlagDTO` for testing
    func fetchAllCountries() async throws -> [FlagDTO] {
        if shouldThrowError {
            throw URLError(.badServerResponse)
        } else {
            return [MockFlagDTOFactory.makeMock()]
        }
    }

    /// Simulates fetching details for a specific country.
    ///
    /// - Parameter name: The name of the country to fetch (ignored in this mock)
    /// - Throws: `URLError(.cannotFindHost)` if `shouldThrowError` is `true`
    /// - Returns: An array with a mock `CountryDetailElement` representing Colombia
    func fetchCountryDetail(name: String) async throws -> [CountryDetailElement] {
        if shouldThrowError {
            throw URLError(.cannotFindHost)
        } else {
            return MockCountryDetailFactory.makeMockList()
        }
    }
}
