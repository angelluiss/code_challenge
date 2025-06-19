//
//  CountryDetailMapper.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 27/05/25.
//

import Foundation

final class CountryDetailMapper {
    
    /// Maps a `CountryDetailElement` data transfer object to a `CountryDetail` domain model
    ///
    /// - Parameter dto: The DTO representing raw country details received from the API
    /// - Returns: A mapped `CountryDetail` model used by the app UI or business logic
    static func map(dto: CountryDetailElement) -> CountryDetail {
        CountryDetail(
            id: dto.idd.root,
            name: dto.name.common,
            officialName: dto.name.official,
            capital: dto.capital.first ?? "Unknown",
            region: dto.region ?? "Unknown",
            subregion: dto.subregion ?? "Unknown",
            population: dto.population,
            area: dto.area,
            symbolCurrency: dto.currencies.firstCurrency?.symbol ?? "Unknown",
            nameCurrency: dto.currencies.firstCurrency?.name ?? "Unknown",
            flagImageURL: dto.flags.png,
            coatOfArmsURL: dto.coatOfArms?.png,
            mapURL: dto.maps.googleMaps,
            languages: dto.languages.values.map(\.value),
            carSide: dto.car.side,
            timezones: dto.timezones
        )
    }
}
