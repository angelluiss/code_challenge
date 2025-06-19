//
//  FavoritesListView.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 6/06/25.
//

import SwiftUI

/// A reusable list view that displays a scrollable list of countries,
/// includes search functionality, and notifies when a country is tapped.
struct FavoritesListView: View, Equatable {
    
    /// The search text bound to an external state, used to filter countries
    @Binding var searchText: String
    
    /// The list of countries to display
    let countries: [Flag]
    
    /// Callback executed when a country is tapped
    let onTap: (Flag) -> Void
    
    /// Optional callback executed when a country is deleted (used in Favorites only)
    let onDelete: ((Flag) -> Void)?
    
    /// Flag to indicate if this view is presented in the favorites tab
    let isInFavoritesTab: Bool
    
    /// Defines equality based only on the list of countries (not search text or callback)
    static func == (lhs: FavoritesListView, rhs: FavoritesListView) -> Bool {
        lhs.countries == rhs.countries
    }
    
    var body: some View {
        List {
            ForEach(countries, id: \.self) { country in
                CountryRowView(country: country)
                    .onTapGesture {
                        onTap(country)
                    }
            }
            .onDelete { indexSet in
                if isInFavoritesTab, let index = indexSet.first {
                    let country = countries[index]
                    onDelete?(country)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText)
        .listStyle(PlainListStyle())
    }
}
