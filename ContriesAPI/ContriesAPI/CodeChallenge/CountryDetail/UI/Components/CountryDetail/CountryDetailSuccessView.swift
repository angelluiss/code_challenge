//
//  CountryDetailSuccessView.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 30/05/25.
//

import CoreModule
import SwiftUI

/// A view that presents detailed information about a specific country
/// after it has been successfully loaded, including flag, region, population,
/// languages, car side, coat of arms, and more.
struct CountryDetailSuccessView: View {
    
    /// The country detail data used to populate the view
    let country: CountryDetail
    
    /// Equatable conformance for performance optimization
    static func == (lhs: CountryDetailSuccessView, rhs: CountryDetailSuccessView) -> Bool {
        lhs.country == rhs.country
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 12) {
                
                // Country Flag with overlayed name and official name
                AsyncImage(url: URL(string: country.flagImageURL)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: AppTheme.Dimension.widthImageMax)
                            .padding(.horizontal, AppTheme.Dimension.paddingS)
                    case .failure:
                        Text("Failed to load image")
                    default:
                        ProgressView()
                    }
                }
                .overlay(alignment: .bottomLeading) {
                    VStack{
                        Text(country.name)
                            .font(.title3)
                            .bold()

                        Text(country.officialName)
                            .font(.subheadline)
                    }
                    .padding(AppTheme.Dimension.paddingS)
                    .background(.white.opacity(0.98))
                    .cornerRadius(AppTheme.Dimension.cornerRadius)
                    .shadow(radius: AppTheme.Dimension.cornerRadius)
                    .padding(.leading, AppTheme.Dimension.padding)
                    .padding(.bottom, -AppTheme.Dimension.paddingXL)
                }
                .padding(.bottom, AppTheme.Dimension.paddingXXL)
                
                // Region, Subregion, Capital
                InfoRowPrincipal(column: [["detail_caption_region".localized : country.region],
                                          ["detail_caption_sub_region".localized: country.subregion],
                                          ["detail_caption_capital".localized:country.capital]])
                .padding(.horizontal, AppTheme.Dimension.padding)
                
                // Timezones and Population
                HStack {
                    InfoRow(label: "detail_caption_timezone".localized, value: country.timezones.joined(separator: ", "))
                    Spacer()
                    InfoRow(label: "detail_caption_population".localized, value: "\(country.population)")
                }
                .padding(.horizontal, AppTheme.Dimension.padding)
                
                // Languages and Currencies
                HStack{
                    InfoRow(label: "detail_caption_languages".localized, value: country.languages.joined(separator: ", "))
                    Spacer()
                    InfoRow(label: "detail_caption_currencies".localized, value: "\(country.nameCurrency.uppercased()) (\(country.symbolCurrency))")
                }
                .padding(.horizontal, AppTheme.Dimension.padding)
                
                // Car driver side and Coat of Arms
                HStack {
                    VStack(spacing: 6) {
                        Text("detail_caption_car_driver_side".localized)
                            .font(.caption)
                            .bold()
                            .padding(.bottom, AppTheme.Dimension.paddingS)
                        HStack{
                            Text("LEFT")
                                .font(.caption)
                                .fontWeight(country.carSide == "left" ? .bold : .regular)
                            Image(systemName: "car.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: AppTheme.Dimension.widthImageS)
                            Text("RIGHT")
                                .fontWeight(country.carSide == "right" ? .bold : .regular)
                                .font(.caption)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: AppTheme.Dimension.widthImageMax / 3, maxHeight: AppTheme.Dimension.widthImage)
                    .padding(AppTheme.Dimension.padding)
                    .background(.white.opacity(0.98))
                    .cornerRadius(AppTheme.Dimension.cornerRadius)
                    .shadow(radius: AppTheme.Dimension.cornerRadius)
                    
                    Spacer()
                    
                    VStack(spacing: 6) {
                        Text("detail_caption_coat".localized)
                            .font(.caption)
                            .bold()
                            .padding(.bottom, AppTheme.Dimension.paddingS)
                        if let urlCoat = country.coatOfArmsURL {
                            AsyncImage(url: URL(string: urlCoat)) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: AppTheme.Dimension.widthImageS)
                                case .failure:
                                    Text("Failed to load image")
                                default:
                                    ProgressView()
                                }
                            }
                        }
                        Spacer()
                    }
                    .frame(maxWidth: AppTheme.Dimension.widthImageMax / 3, maxHeight: AppTheme.Dimension.widthImage)
                    .padding(AppTheme.Dimension.padding)
                    .background(.white.opacity(0.98))
                    .cornerRadius(AppTheme.Dimension.cornerRadius)
                    .shadow(radius: AppTheme.Dimension.cornerRadius)
                }
                .padding(.horizontal, AppTheme.Dimension.padding)
                
                Spacer()
            }
            .padding(AppTheme.Dimension.padding)
        }
        .navigationTitle(country.name)
    }
}

