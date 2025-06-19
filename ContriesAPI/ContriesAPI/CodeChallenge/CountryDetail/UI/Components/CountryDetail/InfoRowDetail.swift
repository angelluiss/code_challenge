//
//  InfoRowDetail.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 28/05/25.
//

import CoreModule
import SwiftUI

/// A reusable vertical component that displays a labeled value inside a styled card,
/// often used for showing simple metadata like population, timezone, or currency.
struct InfoRow: View {
    
    /// The label describing the type of information (e.g., "Population")
    let label: String
    
    /// The actual value associated with the label (e.g., "48,000,000")
    let value: String

    var body: some View {
        VStack(alignment: .center) {
            Text(label)
                .font(.caption)
                .bold()
                .padding(.bottom, AppTheme.Dimension.paddingS)
            Text(value)
                .font(.caption)
            Spacer()
        }
        .frame(maxWidth: AppTheme.Dimension.widthImageMax / 3)
        .padding(AppTheme.Dimension.padding)
        .background(.white.opacity(0.98))
        .cornerRadius(AppTheme.Dimension.cornerRadius)
        .shadow(radius: AppTheme.Dimension.cornerRadius)
    }
}
