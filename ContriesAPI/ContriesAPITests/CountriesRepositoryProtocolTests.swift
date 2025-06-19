//
//  CountriesRepositoryProtocolTests.swift
//  ContriesAPITests
//
//  Created by Angel Gabriel Rangel Pinero on 30/05/25.
//

import Foundation
import Testing
@testable import ContriesAPI
@testable import CoreModule

/// A test suite that verifies the behavior of `CountriesRepositoryProtocol`
/// using a mocked implementation of `MockCountriesRepository`.
struct CountriesRepositoryProtocolTests {
    
    /// Tests that `fetchAllCountries()` returns a non-empty list when no error is thrown
    @Test("fetchAllCountries returns non-empty list when no error")
    func testFetchAllCountriesSuccess() async throws {
        let repository = MockCountriesRepository()
        let result = try await repository.fetchAllCountries()
        
        // Assert that the result is not empty and the first country is "CO"
        #expect(!result.isEmpty)
        #expect(result.first?.cca2 == "CO")
    }

    /// Tests that `fetchAllCountries()` throws an error when `shouldThrowError` is set to true
    @Test("fetchAllCountries throws when shouldThrowError is true")
    func testFetchAllCountriesFailure() async throws {
        let repository = MockCountriesRepository()
        repository.shouldThrowError = true

        do {
            _ = try await repository.fetchAllCountries()
            // If no error is thrown, fail the test
            #expect(Bool(false), "Expected to throw an error but did not")
        } catch {
            // Assert that the thrown error is a URLError
            #expect(error is URLError)
        }
    }

    /// Tests that `fetchCountryDetail()` returns a valid result when no error is thrown
    @Test("fetchCountryDetail returns detail when no error")
    func testFetchCountryDetailSuccess() async throws {
        let repository = MockCountriesRepository()
        let result = try await repository.fetchCountryDetail(name: "Colombia")
        
        // Assert that at least one detail is returned and it's for "Colombia"
        #expect(!result.isEmpty)
        #expect(result.first?.name.common == "Colombia")
    }

    /// Tests that `fetchCountryDetail()` throws an error when `shouldThrowError` is true
    @Test("fetchCountryDetail throws when shouldThrowError is true")
    func testFetchCountryDetailFailure() async throws {
        let repository = MockCountriesRepository()
        repository.shouldThrowError = true

        do {
            _ = try await repository.fetchCountryDetail(name: "Colombia")
            // If no error is thrown, fail the test
            #expect(Bool(false), "Expected to throw an error but did not")
        } catch {
            // Assert that the error is of type URLError
            #expect(error is URLError)
        }
    }
}
