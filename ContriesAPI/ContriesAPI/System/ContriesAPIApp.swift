//
//  ContriesAPIApp.swift
//  ContriesAPI
//
//  Created by Choudhary, Alok on 9/6/23.
//

import CoreModule
import SwiftData
import SwiftUI

@main
struct ContriesAPIAPP: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            CountriesHomeView()
                .environmentObject(appDelegate.appCoordinator!)
                .environment(\.modelContext, appDelegate.modelContainer.mainContext)
        }
    }
}
