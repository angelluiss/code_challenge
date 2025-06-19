//
//  CountryListViewComponent.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 27/05/25.
//

import SwiftUI

/// A reusable list view that displays a scrollable list of countries,
/// includes search functionality, and notifies when a country is tapped.
struct CountryListView: View, Equatable {
    
    /// The search text bound to an external state, used to filter countries
    @Binding var searchText: String
    
    /// The list of countries to display
    let countries: [Flag]
    
    /// Callback executed when a country is tapped
    let onTap: (Flag) -> Void
    
    /// Defines equality based only on the list of countries (not search text or callback)
    static func == (lhs: CountryListView, rhs: CountryListView) -> Bool {
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
        }
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText)
        .listStyle(PlainListStyle())
    }
}
