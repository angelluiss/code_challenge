//
//  CountriesHomeView.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 27/05/25.
//

import CoreModule
import SwiftData
import SwiftUI

/// The main container view that displays the tab-based interface for the app,
/// including a search view and a list of saved (favorite) countries.
struct CountriesHomeView: View {
    
    /// SwiftData model context used for database operations
    @Environment(\.modelContext) private var modelContext
    
    /// The shared app coordinator managing navigation and tabs
    @EnvironmentObject var appCoordinator: AppCoordinatorImpl
    
    /// ViewModel responsible for managing the favorites screen
    @StateObject private var favoritesViewModel = FavoritesViewModel()

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                // Switch between the current tab selected in the app
                switch appCoordinator.currentTab {
                case .home:
                    NavigationStack(path: $appCoordinator.path) {
                        appCoordinator.build(.home)
                            .navigationDestination(for: Screen.self) { screen in
                                appCoordinator.build(screen)
                            }
                    }
                    .environmentObject(appCoordinator)
                case .favorites:
                    FavoritesView()
                        .environmentObject(favoritesViewModel)
                }
            }
            
            // Custom bottom tab bar with navigation icons
            CustomTabBar(
                selectedTab: $appCoordinator.currentTab,
                items: [
                    CustomTabItem(icon: "magnifyingglass", title: "Search", tab: .home),
                    CustomTabItem(icon: "star.fill", title: "Saved", tab: .favorites)
                ]
            )
        }
    }
}

