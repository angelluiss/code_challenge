//
//  CountryListRowComponent.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 27/05/25.
//

import CoreModule
import SwiftUI

/// A reusable row view that displays basic country information, including its flag, name,
/// official name, capital, and a bookmark icon if it's marked as favorite.
struct CountryRowView: View {
    
    /// The country data to be displayed in the row
    let country: Flag

    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                /// Asynchronously loads and displays the country’s flag image
                AsyncImage(url: URL(string: country.flagImageURL)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: AppTheme.Dimension.widthImage)
                    case .failure:
                        Text("Failed to load image")
                    default:
                        ProgressView()
                    }
                }

                /// Displays country details: name, official name, and capital
                VStack(alignment: .leading, spacing: 2) {
                    Text(country.name)
                        .font(.title3)
                        .bold()
                    Text(country.officialName)
                        .font(.subheadline)
                        .bold()
                    Text(country.capital)
                        .font(.caption2)
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 4)
            )
            .foregroundStyle(AppTheme.Color.primaryText)
            
            /// Displays a bookmark icon if the country is marked as favorite
            if country.isFavorite {
                Image(systemName: "bookmark.fill")
                    .foregroundColor(.blue)
                    .padding([.top, .trailing], 8)
            } else {
                Image(systemName: "bookmark")
                    .foregroundColor(.blue)
                    .padding([.top, .trailing], 8)
            }
        }
    }
}
