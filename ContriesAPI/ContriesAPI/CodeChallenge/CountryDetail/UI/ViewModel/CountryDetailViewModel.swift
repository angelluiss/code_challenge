//
//  CountryDetailViewModel.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 27/05/25.
//

import CoreModule
import Foundation
import SwiftData

/// ViewModel responsible for managing the state and data of a specific country detail screen,
/// including loading details and handling favorites.
@MainActor
class CountryDetailViewModel: ObservableObject {
    
    /// The name of the country used to fetch its details
    @Published var countryName: String
    
    /// The current UI state (idle, loading, success, or failure)
    @Published var uiState: CommonUIState = .idle
    
    /// The detailed data of the selected country
    @Published var countryDetail: CountryDetail? = nil
    
    /// Boolean indicating whether the country is marked as favorite
    @Published var isFavorite: Bool = false
    
    /// The repository responsible for fetching country data
    private let countryRepository: CountriesRepositoryProtocol
    
    /// Initializes the view model with the provided country name and repository
    ///
    /// - Parameters:
    ///   - parameter: The name of the country to be loaded
    ///   - countryRepository: The repository used to fetch country details
    init(parameter: String, countryRepository: CountriesRepositoryProtocol) {
        self.countryName = parameter
        self.countryRepository = countryRepository
    }
    
    /// Fetches detailed information for the selected country and updates the UI state accordingly
    func fetchCountriesDetail() async {
        uiState = .loading
        do {
            let countryDetailDTO: [CountryDetailElement] = try await countryRepository.fetchCountryDetail(name: countryName)
            guard let countryDetail = countryDetailDTO.first else {
                uiState = .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No country found"]))
                return
            }
            let countries = CountryDetailMapper.map(dto: countryDetail)
            self.countryDetail = countries
            uiState = .success(countries)
        } catch {
            uiState = .failure(error)
        }
    }
    
    /// Saves the current country to the favorites list using the given SwiftData context
    ///
    /// - Parameter context: The SwiftData `ModelContext` used to persist the favorite
    func saveToFavorites(context: ModelContext) {
        if !isFavorite {
            let favorite = FavoriteCountry()
            if let country = countryDetail {
                favorite.name = country.name
                favorite.officialName = country.officialName
                favorite.flagImageURL = country.flagImageURL
                favorite.capital = country.capital
                context.insert(favorite)
            }
            isFavorite = true
        }        
    }
    
    /// Checks if the current country is already marked as favorite
    ///
    /// - Parameter context: The SwiftData `ModelContext` used to query for favorites
    func checkIsFavorite(context: ModelContext) async {
        guard let name = countryDetail?.name else { return }

        let descriptor = FetchDescriptor<FavoriteCountry>(
            predicate: #Predicate { $0.name == name }
        )
        do {
            let results = try context.fetch(descriptor)
            isFavorite = !results.isEmpty
        } catch {
            print("Error checking favorite: \(error)")
        }
    }
}
