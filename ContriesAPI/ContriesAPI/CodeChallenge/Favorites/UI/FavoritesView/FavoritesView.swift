//
//  FavoritesView.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 31/05/25.
//

import CoreModule
import SwiftData
import SwiftUI

/// A view that displays the list of saved (favorite) countries with search capability.
/// Uses `SwiftData` for persistent storage and loads data on appearance.
struct FavoritesView: View {
    
    /// The SwiftData model context used to fetch favorite countries
    @Environment(\.modelContext) private var modelContext
    
    /// The shared app coordinator used for navigation (e.g., to detail screens)
    @EnvironmentObject private var appCoordinator: AppCoordinatorImpl
    
    /// The view model managing the list of favorites and search functionality
    @EnvironmentObject private var viewModel: FavoritesViewModel

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: AppTheme.Dimension.padding) {
                
                /// A searchable list of favorite countries
                FavoritesListView(searchText: $viewModel.searchText, countries: viewModel.filteredSavedCountries,
                                onTap: { country in
                    // Navigation action can be added here (e.g. appCoordinator.push(.detailView(country.name)))
                },
                                onDelete: { country in
                    viewModel.removeFavorite(country, context: modelContext)
                },
                isInFavoritesTab: true)
            }
            .navigationTitle("Saved")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            // Refresh favorites when the view appears
            viewModel.fetchFavorites(context: modelContext)
        }
        .padding(AppTheme.Dimension.padding)
        .background(AppTheme.Color.primaryBackground)
    }
}
