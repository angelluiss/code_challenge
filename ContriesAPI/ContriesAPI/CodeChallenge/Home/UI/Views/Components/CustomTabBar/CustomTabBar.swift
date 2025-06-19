//
//  CustomTabBar.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 30/05/25.
//

import CoreModule
import Foundation
import SwiftUI

/// A custom bottom tab bar used to switch between different root-level views in the app
struct CustomTabBar: View {
    
    /// The currently selected tab, bound to the parent view
    @Binding var selectedTab: RootTab
    
    /// The list of items (tabs) to display in the bar
    let items: [CustomTabItem]
    
    var body: some View {
        HStack {
            ForEach(items, id: \.tab) { item in
                Spacer()
                tabItemBarButton(item: item)
                Spacer()
            }
        }
        .padding()
        .background(Color(.systemBackground).shadow(radius: 2))
    }
    
    /// Creates a tab bar button for a given item
    ///
    /// - Parameter item: The `CustomTabItem` containing icon, title, and tab identifier
    @ViewBuilder
    private func tabItemBarButton(item: CustomTabItem) -> some View {
        Button(action: {
            selectedTab = item.tab
        }) {
            VStack {
                Image(systemName: item.icon)
                Text(item.title)
            }
            .foregroundColor(selectedTab == item.tab ? .blue : .gray)
        }
    }
}

/// A model representing an item in the custom tab bar
struct CustomTabItem {
    
    /// The system icon name to display in the tab
    let icon: String
    
    /// The title displayed below the icon
    let title: String
    
    /// The associated root tab enum case
    let tab: RootTab
}
