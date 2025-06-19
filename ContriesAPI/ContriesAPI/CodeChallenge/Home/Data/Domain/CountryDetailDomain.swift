//
//  CountryDetailDomain.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 27/05/25.
//

import Foundation

struct CountryDetail: Identifiable, Equatable {
    let id: String 
    let name: String
    let officialName: String
    let capital: String
    let region: String
    let subregion: String
    let population: Int
    let area: Double
    let symbolCurrency: String
    let nameCurrency: String
    let flagImageURL: String
    let coatOfArmsURL: String?
    let mapURL: String
    let languages: [String]
    let carSide: String
    let timezones: [String]
}
