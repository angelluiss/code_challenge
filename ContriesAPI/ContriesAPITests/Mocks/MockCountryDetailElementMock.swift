//
//  MockFCountryDetailElementMock.swift
//  ContriesAPITests
//
//  Created by Angel Gabriel Rangel Pinero on 30/05/25.
//

import Foundation
@testable import ContriesAPI

/// A factory that provides mock instances of `CountryDetailElement`
/// used for testing country detail features without relying on actual API responses.
enum MockCountryDetailFactory {
    
    /// Creates a single mock `CountryDetailElement` representing Colombia
    ///
    /// - Returns: A fully initialized `CountryDetailElement` with representative test data
    static func makeMock() -> CountryDetailElement {
        return CountryDetailElement(
            name: Name(
                common: "Colombia",
                official: "República de Colombia",
                nativeName: NativeName(values: [
                    "spa": Translation(official: "República de Colombia", common: "Colombia")
                ])
            ),
            tld: [".co"],
            independent: true,
            status: "officially-assigned",
            currencies: Currencies(values: [
                "COP": Currencies.Currency(name: "Colombian peso", symbol: "$")
            ] ),
            idd: Idd(root: "+57", suffixes: ["1"]),
            capital: ["Bogotá"],
            altSpellings: ["CO", "Republic of Colombia", "República de Colombia"],
            region: "Americas",
            subregion: "South America",
            languages: Languages(values: ["spa": "Spanish"]),
            latlng: [4.5709, -74.2973],
            area: 1141748,
            cca3: "COL",
            translations: [:],
            flag: "🇨🇴",
            maps: Maps(
                googleMaps: "https://maps.google.com/?q=Colombia",
                openStreetMaps: "https://osm.org/Colombia"
            ),
            population: 50882884,
            fifa: "COL",
            car: Car(signs: ["CO"], side: "right"),
            timezones: ["UTC-05:00"],
            continents: ["South America"],
            flags: Flags(
                png: "https://flagcdn.com/w320/co.png",
                svg: "https://flagcdn.com/co.svg",
                alt: "Flag of Colombia"
            ),
            coatOfArms: CoatOfArms(
                png: "https://example.com/coat.png",
                svg: "https://example.com/coat.svg"
            ),
            startOfWeek: "monday",
            capitalInfo: CapitalInfo(latlng: [4.7110, -74.0721])
        )
    }

    /// Returns a list containing a single mock `CountryDetailElement`
    ///
    /// - Returns: An array with one mock country detail (Colombia)
    static func makeMockList() -> [CountryDetailElement] {
        return [makeMock()]
    }
}
