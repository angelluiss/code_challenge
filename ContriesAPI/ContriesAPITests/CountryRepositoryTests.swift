//
//  CountryRepositoryTests.swift
//  ContriesAPITests
//
//  Created by Angel Gabriel Rangel Pinero on 28/05/25.
//

import XCTest
@testable import ContriesAPI

/// Unit tests for the `CountryRepository` class, ensuring correct interaction with `NetworkServiceProtocol`
final class CountryRepositoryTests: XCTestCase {
    
    /// Tests that `fetchAllCountries()` returns the expected list of countries
    func test_fetchAllCountries_returnsCountries() async throws {
        // Arrange:
        // Create a mock network service and provide a predefined response
        let mockService = MockNetworkService()
        let expectedCountries = MockFlagDTOFactory.makeMockList()
        mockService.mockResponse = expectedCountries
        
        let repository = CountryRepository(networkService: mockService)

        // Act:
        // Call the method under test
        let result = try await repository.fetchAllCountries()
        
        // Assert:
        // Check that the number of returned items and their content match expectations
        XCTAssertEqual(result.count, expectedCountries.count)
        XCTAssertEqual(result.first?.cca2, expectedCountries.first?.cca2)
    }
}

