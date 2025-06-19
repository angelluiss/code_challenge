//
//  CountryDetailView.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 27/05/25.
//

import CoreModule
import SwiftData
import SwiftUI

/// A view that displays detailed information about a specific country,
/// along with the ability to save it as a favorite and navigate back.
struct CountryDetailView: View {
    
    /// The SwiftData model context used for accessing local favorites
    let modelContext: ModelContext
    
    /// The ViewModel responsible for managing the country detail state
    @StateObject private var viewModel: CountryDetailViewModel
    
    /// The app coordinator used for handling navigation
    @EnvironmentObject private var appCoordinator: AppCoordinatorImpl

    /// Initializes the detail view with a country name and model context
    ///
    /// - Parameters:
    ///   - parameter: The country name used to fetch detail data
    ///   - modelContext: The SwiftData context for checking and saving favorites
    init(parameter: String, modelContext: ModelContext) {
        self.modelContext = modelContext
        _viewModel = StateObject(
            wrappedValue: CountryDetailViewModel(
                parameter: parameter,
                countryRepository: CountryRepository(networkService: NetworkService())
            )
        )
    }

    var body: some View {
        VStack {
            contentView
        }
        .task {
            await viewModel.fetchCountriesDetail()
            await viewModel.checkIsFavorite(context: modelContext)
        }
    }

    /// Returns a view depending on the UI state: idle, loading, success or failure
    @ViewBuilder
    private var contentView: some View {
        VStack {
            switch viewModel.uiState {
            case .idle:
                Spacer()
                Text("Waiting for input...")
                Spacer()
            case .loading:
                ProgressView()
            case .success(let country):
                CountryDetailSuccessView(country: country)
            case .failure(let error):
                Spacer()
                Text("Error: \(error.localizedDescription)")
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .customNavigationBar(
            backText: "Search",
            title: "",
            trailingView: {
                Image(systemName: viewModel.isFavorite ? "bookmark.fill" : "bookmark")
                    .foregroundColor(.blue)
                    .onTapGesture {
                        viewModel.saveToFavorites(context: modelContext)
                    }
            },
            onBack: {
                appCoordinator.pop()
            }
        )
    }
}
