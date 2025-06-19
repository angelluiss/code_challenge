//
//  AppDelegate.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 27/05/25.
//

import SwiftUI
import CoreModule
import SwiftData

class AppDelegate: UIResponder, UIApplicationDelegate {
    /// Main application window
    var window: UIWindow?
    
    /// Reference to the app's main coordinator
    var appCoordinator: AppCoordinatorImpl?
    
    /// SwiftData model container for persistent storage
    var modelContainer: ModelContainer!
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        do {
            modelContainer = try ModelContainer(for: FavoriteCountry.self)
        } catch {
            fatalError("❌ Failed to create ModelContainer: \(error)")
        }
        let screenBuilder = RoutesFactory.makeScreenBuilder(modelContext: modelContainer.mainContext)
        
        let appCoordinator = AppCoordinatorImpl(
            screenBuilder: screenBuilder
        )
        self.appCoordinator = appCoordinator
        
        let rootView = CountriesHomeView()
            .environmentObject(appCoordinator)
        
        let hostingController = UIHostingController(rootView: rootView)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = hostingController
        window?.makeKeyAndVisible()
        
        return true
    }
}

