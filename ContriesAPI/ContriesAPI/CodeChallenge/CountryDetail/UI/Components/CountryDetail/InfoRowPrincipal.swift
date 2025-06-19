//
//  InfoRowPrincipal.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 4/06/25.
//

import CoreModule
import SwiftUI

/// A reusable horizontal row that displays a set of key-value pairs in columns,
/// typically used for displaying concise info blocks (e.g., statistics or metadata).
struct InfoRowPrincipal: View {
    
    /// The array of key-value string dictionaries to display as columns
    let column: [[String: String]]

    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            ForEach(Array(column.enumerated()), id: \.element) { index, word in
                if let key = word.keys.first, let value = word.values.first {
                    VStack {
                        Text(key)
                            .font(.caption)
                            .bold()
                        
                        Text(value)
                            .font(.caption)
                    }
                    
                    // Only show separator if not the last element
                    if index < column.count - 1 {
                        Text("|")
                            .padding(.horizontal)
                    }
                }
            }
            Spacer()
        }
        .padding(AppTheme.Dimension.paddingS)
        .padding(.vertical)
        .background(.white.opacity(0.98))
        .cornerRadius(AppTheme.Dimension.cornerRadius)
        .shadow(radius: AppTheme.Dimension.cornerRadius)
    }
}
