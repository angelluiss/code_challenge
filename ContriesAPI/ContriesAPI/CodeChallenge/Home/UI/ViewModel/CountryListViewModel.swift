//
//  CountryListViewModel.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 27/05/25.
//

import CoreModule
import Foundation
import SwiftData

/// ViewModel responsible for fetching and managing the list of countries,
/// including search and favorite status handling.
@MainActor
class CountryListViewModel: ObservableObject {
    
    /// The full list of countries retrieved from the API
    @Published var countryList: [Flag] = []
    
    /// The current search text used to filter countries
    @Published var searchText: String = ""
    
    /// The filtered list of countries based on the search text
    var filteredCountries: [Flag] {
        guard !searchText.isEmpty else { return countryList }
        return countryList.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    /// The repository used to fetch country data
    private let countryRepository: CountriesRepositoryProtocol
    
    /// The SwiftData context used to fetch favorite countries
    private let modelContext: ModelContext
    
    /// Initializes a new instance of the view model
    ///
    /// - Parameters:
    ///   - countryRepository: A repository that provides country data from the network
    ///   - modelContext: A SwiftData context for accessing persistent favorites
    init(countryRepository: CountriesRepositoryProtocol, modelContext: ModelContext) {
        self.countryRepository = countryRepository
        self.modelContext = modelContext
    }
    
    /// Asynchronously fetches the list of countries from the repository and updates their favorite status
    func fetchCountries() async {
        do {
            let countryListDTO: [FlagDTO] = try await countryRepository.fetchAllCountries()
            let countries = FlagListMapper.map(dtoList: countryListDTO)
            let favorites = try modelContext.fetch(FetchDescriptor<FavoriteCountry>())
            let favoriteNames = Set(favorites.map { $0.name })
            
            self.countryList = countries.map { flag in
                var modified = flag
                modified.isFavorite = favoriteNames.contains(flag.name)
                return modified
            }
        } catch {
            if (error as? URLError)?.code != .cancelled {
                print("Error fetching countries: \(error)")
            }
        }
    }
}
