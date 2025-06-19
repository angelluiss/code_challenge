//
//  CountryListViewModelTest.swift
//  ContriesAPITests
//
//  Created by Angel Gabriel Rangel Pinero on 4/06/25.
//

import Testing
import SwiftData
@testable import ContriesAPI
@testable import CoreModule

// MARK: - Helper

/// Creates an in-memory `ModelContext` and inserts a sample `FavoriteCountry`
///
/// - Parameter name: The name of the favorite country to insert (default is "France")
/// - Returns: A SwiftData `ModelContext` preloaded with one favorite
@MainActor
func makeModelContextWithFavorite(name: String = "France") throws -> ModelContext {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try ModelContainer(for: FavoriteCountry.self, configurations: config)

    let favorite = FavoriteCountry(
        name: name,
        officialName: "\(name) Official",
        flagImageURL: "https://flagcdn.com/\(name.lowercased()).png",
        capital: "Capital"
    )
    container.mainContext.insert(favorite)

    return container.mainContext
}

// MARK: - Test: Fetch countries and check favorites

/// Tests that `CountryListViewModel.fetchCountries()` correctly sets `.isFavorite`
/// based on SwiftData's stored `FavoriteCountry` entries
@Test
@MainActor
func testFetchCountriesMarksFavorites() async throws {
    
    // Provide mock response
    let mockRepo = MockCountriesRepository()
    
    // Create in-memory context with France as favorite
    let context = try makeModelContextWithFavorite(name: "France")
    let viewModel = CountryListViewModel(countryRepository: mockRepo, modelContext: context)
    
    // Act
    await viewModel.fetchCountries()

    // Assert
    #expect(viewModel.countryList.count == 2)
    #expect(viewModel.countryList.first(where: { $0.name == "France" })?.isFavorite == true)
    #expect(viewModel.countryList.first(where: { $0.name == "Germany" })?.isFavorite == false)
}

/// Tests that the search text filters the country list properly
@Test
@MainActor
func testSearchTextFiltersCorrectly() async throws {
    
    // Provide mock response
    let mockRepo = MockCountriesRepository()
    try await mockRepo.fetchAllCountries()
    
    // Create in-memory context with France as favorite
    let context = try makeModelContextWithFavorite()
    let viewModel = CountryListViewModel(countryRepository: mockRepo, modelContext: context)
    
    // Act
    await viewModel.fetchCountries()
    viewModel.searchText = "col"

    // Assert
    #expect(viewModel.filteredCountries.count == 1)
    #expect(viewModel.filteredCountries.first?.name == "Colombia")
}
