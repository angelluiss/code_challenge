//
//  File.swift
//  CoreModule
//
//  Created by Angel Gabriel Rangel Pinero on 28/05/25.
//

import Foundation
import SwiftUI

extension String {
    /// Returns the localized version of the string using `NSLocalizedString`
    public var localized: String {
        NSLocalizedString(self, comment: "")
    }
}

extension View {
    /// Applies a custom navigation bar with a back button, title, and an optional trailing view
    ///
    /// - Parameters:
    ///   - backText: The text shown next to the back chevron (default: "Back")
    ///   - title: The title to display at the center of the navigation bar
    ///   - trailingView: A trailing view (e.g., button or icon) shown on the right side
    ///   - onBack: The action to perform when the back button is tapped
    /// - Returns: A view with the custom navigation bar applied
    public func customNavigationBar<TrailingView: View>(
        backText: String = "Back",
        title: String,
        @ViewBuilder trailingView: @escaping () -> TrailingView,
        onBack: @escaping () -> Void
    ) -> some View {
        self.modifier(
            CustomNavigationBarModifier(
                backText: backText,
                title: title,
                trailingView: trailingView,
                onBack: onBack
            )
        )
    }
}
