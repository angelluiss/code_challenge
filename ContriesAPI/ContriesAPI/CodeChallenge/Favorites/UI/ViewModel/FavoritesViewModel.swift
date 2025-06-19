//
//  FavoritesViewModel.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 31/05/25.
//

import CoreModule
import Foundation
import SwiftData

/// ViewModel responsible for managing and displaying the list of favorite countries.
/// Includes filtering support based on search text.
@MainActor
class FavoritesViewModel: ObservableObject {
    
    /// The list of favorite countries stored locally
    @Published var favorites: [Flag] = []
    
    /// The current text input used for filtering favorite countries
    @Published var searchText: String = ""
    
    /// The filtered list of favorite countries based on the search text
    var filteredSavedCountries: [Flag] {
        guard !searchText.isEmpty else { return favorites }
        return favorites.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    /// Fetches favorite countries from the local SwiftData store and maps them to `Flag` models
    ///
    /// - Parameter context: The SwiftData `ModelContext` used to perform the fetch
    func fetchFavorites(context: ModelContext) {
        let descriptor = FetchDescriptor<FavoriteCountry>()
        do {
            let results = try context.fetch(descriptor)
            self.favorites = results.map { favoriteCountry in
                Flag(
                    name: favoriteCountry.name ?? "",
                    officialName: favoriteCountry.officialName ?? "",
                    code: "",
                    region: "",
                    flagImageURL: favoriteCountry.flagImageURL ?? "",
                    capital: favoriteCountry.capital ?? "",
                    isFavorite: true
                )
            }
        } catch {
            print("Failed to fetch favorites: \(error)")
        }
    }
    
    /// Removes a favorite country from the local SwiftData store
    ///
    /// - Parameters:
    ///   - country: The `Flag` object representing the country to be removed
    ///   - context: The `ModelContext` used to perform the deletion
    func removeFavorite(_ country: Flag, context: ModelContext) {
        let descriptor = FetchDescriptor<FavoriteCountry>()
        
        do {
            let results = try context.fetch(descriptor)
            
            for item in results where item.name == country.name {
                context.delete(item)
            }
            try context.save()
            
            self.fetchFavorites(context: context)
        } catch {
            print("Failed to remove favorite: \(error)")
        }
    }
}
