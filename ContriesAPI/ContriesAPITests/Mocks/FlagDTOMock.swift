//
//  FlagDTOMock.swift
//  ContriesAPITests
//
//  Created by Angel Gabriel Rangel Pinero on 28/05/25.
//

import Foundation
@testable import ContriesAPI

/// A factory that provides mock instances of `FlagDTO` for unit testing.
enum MockFlagDTOFactory {
    
    /// A single hardcoded mock instance representing Colombia.
    private static let colombiaMock = FlagDTO(
        name: NameDTO(
            common: "Colombia",
            official: "República de Colombia",
            nativeName: [
                "spa": TranslationDTO(official: "República de Colombia", common: "Colombia")
            ]
        ),
        tld: [".co"],
        cca2: "CO",
        cioc: "COL",
        independent: true,
        status: "officially-assigned",
        currencies: [
            "COP": CurrencyDTO(symbol: "$", name: "Colombian peso")
        ],
        capital: ["Bogotá"],
        region: "Americas",
        subregion: "South America",
        languages: [
            "spa": "Spanish"
        ],
        latlng: [4.5709, -74.2973],
        borders: ["BRA", "ECU", "PER"],
        area: 1141748,
        translations: [:],
        maps: MapsDTO(
            googleMaps: "https://maps.google.com/?q=Colombia",
            openStreetMaps: "https://osm.org/Colombia"
        ),
        flags: ImageDTO(
            png: "https://flagcdn.com/w320/co.png",
            svg: "https://flagcdn.com/co.svg",
            alt: "Flag of Colombia"
        ),
    )

    /// Returns a single mock instance of `FlagDTO` (Colombia).
    static func makeMock() -> FlagDTO {
        return colombiaMock
    }

    /// Returns a list containing one or more mock `FlagDTO` values.
    static func makeMockList() -> [FlagDTO] {
        return [colombiaMock]
    }
}
