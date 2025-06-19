//
//  AppCoordinator.swift
//  CoreModule
//
//  Created by Angel Rangel on 14/01/25.
//

import Foundation
import SwiftUI

@available(iOS 16.0, *)
public class AppCoordinatorImpl: AppCoordinatorProtocol {
    
    /// Navigation path used to manage the navigation stack
    @Published public var path: NavigationPath = NavigationPath()
    
    /// Current selected tab in the root view
    @Published public var currentTab: RootTab = .home
    
    /// Currently active screen in the navigation flow
    @Published public var currentScreen: Screen?
    
    /// Boolean value indicating whether the current screen is a detail view
    public var isInDetailView: Bool {
        if case .detailView = currentScreen {
            return true
        }
        return false
    }

    /// Closure used to build a view for a given screen
    private let screenBuilder: (Screen) -> AnyView
    
    /// Initializes a new instance of the app coordinator
    /// - Parameter screenBuilder: A closure that returns a view for the provided screen
    public init(
        screenBuilder: @escaping (Screen) -> AnyView
    ) {
        self.screenBuilder = screenBuilder
    }
    
    /// Pushes a new screen onto the navigation stack
    /// - Parameter screen: The screen to navigate to
    public func push(_ screen: Screen) {
        path.append(screen)
        currentScreen = screen
    }

    /// Pops the top screen from the navigation stack
    public func pop() {
        currentScreen = nil
        path.removeLast()
    }
    
    /// Pops all screens and returns to the root of the navigation stack
    public func popToRoot() {
        path.removeLast(path.count)
    }
    
    /// Builds the view associated with the given screen
    /// - Parameter screen: The screen to render
    /// - Returns: A SwiftUI view corresponding to the screen
    @ViewBuilder
    public func build(_ screen: Screen) -> some View {
        switch screen {
        case .home:
            screenBuilder(.home)
        case .detailView(let parameter):
            screenBuilder(.detailView(parameter))
        }
    }
}

