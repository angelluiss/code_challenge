//
//  ContentView.swift
//  ContriesAPI
//
//  Created by Choudhary, Alok on 9/6/23.
//

import CoreModule
import SwiftData
import SwiftUI

/// A view that displays a searchable list of countries retrieved from the API.
/// It allows users to navigate to a detailed view for each country.
struct CountriesListView: View {
    
    /// The SwiftData model context used for persistence and querying favorites
    let modelContext: ModelContext
    
    /// The app coordinator for handling navigation
    @EnvironmentObject private var appCoordinator: AppCoordinatorImpl
    
    /// The view model that manages the state and data of the country list
    @StateObject private var viewModel: CountryListViewModel
    
    /// Initializes the country list view with the required model context
    ///
    /// - Parameter modelContext: The SwiftData context used for database access
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        _viewModel = StateObject(
            wrappedValue: CountryListViewModel(
                countryRepository:
                    CountryRepository(
                        networkService: NetworkService()),
                modelContext: modelContext
            )
        )
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: AppTheme.Dimension.padding) {
                /// A reusable country list component that triggers navigation when a country is selected
                CountryListView(searchText: $viewModel.searchText, countries: viewModel.filteredCountries, onTap: { country in
                    appCoordinator.push(.detailView(country.name))
                })
                .task {
                    await viewModel.fetchCountries()
                }
            }
            .navigationTitle("Countries")
            .navigationBarTitleDisplayMode(.inline)
            .padding(AppTheme.Dimension.padding)
            .background(AppTheme.Color.primaryBackground)
        }
    }
}
