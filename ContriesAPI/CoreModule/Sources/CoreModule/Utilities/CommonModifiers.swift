//
//  File.swift
//  CoreModule
//
//  Created by Angel Gabriel Rangel Pinero on 28/05/25.
//

import Foundation
import SwiftUI

/// A custom navigation bar modifier that adds a consistent header with a back button, title, and optional trailing view.
public struct CustomNavigationBarModifier<TrailingView: View>: ViewModifier {
    
    /// Text displayed next to the back chevron icon
    let backText: String
    
    /// The title displayed in the center of the navigation bar
    let title: String
    
    /// A custom view displayed on the trailing (right) side of the navigation bar
    let trailingView: TrailingView
    
    /// Action to perform when the back button is tapped
    let onBack: () -> Void

    
    /// Initializes a new `CustomNavigationBarModifier`
    ///
    /// - Parameters:
    ///   - backText: The text shown next to the back arrow (default: `"Back"`)
    ///   - title: The centered title for the navigation bar
    ///   - trailingView: A trailing view (e.g., button or icon) shown on the right side
    ///   - onBack: Closure executed when the back button is tapped
    init(
        backText: String = "Back",
        title: String,
        @ViewBuilder trailingView: () -> TrailingView,
        onBack: @escaping () -> Void
    ) {
        self.backText = backText
        self.title = title
        self.trailingView = trailingView()
        self.onBack = onBack
    }

    /// Applies the custom navigation bar layout to the modified content
    ///
    /// - Parameter content: The view content to which the modifier is applied
    /// - Returns: A view with the custom navigation bar overlay
    public func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
                .padding(.top, 44)

            HStack {
                Button(action: onBack) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text(backText)
                            .font(.body)
                    }
                }
                .foregroundColor(.blue)

                Spacer()

                Text(title)
                    .font(.headline)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .center)

                Spacer()

                trailingView
            }
            .padding(.horizontal)
            .frame(height: 44)
            .background(Color(.systemBackground).ignoresSafeArea(edges: .top))
        }
    }
}
