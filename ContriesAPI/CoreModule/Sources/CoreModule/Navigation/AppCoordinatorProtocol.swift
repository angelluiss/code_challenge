//
//  BaseCoordinator.swift
//  CoreModule
//
//  Created by Angel Rangel on 14/01/25.
//


import SwiftUI

/// Represents the different navigation destinations within the app
public enum Screen: Hashable, Identifiable {
    case home
    case detailView(String)
    
    /// A unique identifier for each screen case
    public var id: String {
        switch self {
        case .home: return "home"
        case .detailView(let value): return "detailView_\(value)"
        }
    }
}

/// Represents modal sheets that can be presented in the app
public enum Sheet: Identifiable, Hashable {
    /// Info sheet
    case info

    /// A unique identifier for the sheet
    public var id: Self { self }
}



// MARK: - AppCoordinator Protocol
/// Protocol defining the core navigation responsibilities for an app coordinator
@available(iOS 16.0, *)
public protocol AppCoordinatorProtocol: ObservableObject {
    /// The current navigation path used for stack-based navigation
    var path: NavigationPath { get set }
    
    /// Pushes a new screen onto the navigation stack
    /// - Parameter screen: The screen to navigate to
    func push(_ screen: Screen)
    
    /// Pops the top screen from the navigation stack
    func pop()
    
    /// Pops all screens to return to the root of the stack
    func popToRoot()
}
