//
//  RouteFactory.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 23/05/25.
//

import CoreModule
import Foundation
import SwiftData
import SwiftUI

/// A factory responsible for creating screen builders used in navigation
public class RoutesFactory {
    
    /// Creates a screen builder closure that maps `Screen` values to SwiftUI views
    ///
    /// - Parameter modelContext: The SwiftData model context used for dependency injection
    /// - Returns: A closure that takes a `Screen` enum and returns the corresponding `AnyView`
    public static func makeScreenBuilder(modelContext: ModelContext) -> (Screen) -> AnyView {
        return { screen in
            switch screen {
            case .home:
                return AnyView(CountriesListView(modelContext: modelContext))
            case .detailView(let parameter):
                return AnyView(CountryDetailView(parameter: parameter, modelContext: modelContext))
            }
        }
    }
}
