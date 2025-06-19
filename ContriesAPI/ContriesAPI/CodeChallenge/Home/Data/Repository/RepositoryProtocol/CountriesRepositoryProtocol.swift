//
//  CountriesRepositoryProtocol.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 27/05/25.
//

import CoreModule
import Foundation

/// A protocol that defines the data operations related to countries,
/// such as fetching lists and country details from a remote source.
public protocol CountriesRepositoryProtocol {
    
    /// Fetches a list of all countries with basic information (flags, names, etc.)
    ///
    /// - Returns: An array of `FlagDTO` representing basic country data
    /// - Throws: An error if the request fails or decoding encounters an issue
    func fetchAllCountries() async throws -> [FlagDTO]
    
    /// Fetches detailed information about a specific country
    ///
    /// - Parameter name: The name of the country to fetch details for
    /// - Returns: An array of `CountryDetailElement` containing detailed information about the country
    /// - Throws: An error if the request fails or decoding encounters an issue
    func fetchCountryDetail(name: String) async throws -> [CountryDetailElement]
}
