//
//  CountryListDomain.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 27/05/25.
//

import Foundation

struct Flag: Equatable, Identifiable, Hashable {
    let id: UUID = UUID()
    let name: String
    let officialName: String
    let code: String
    let region: String
    let flagImageURL: String
    let capital: String
    var isFavorite: Bool = false
}
