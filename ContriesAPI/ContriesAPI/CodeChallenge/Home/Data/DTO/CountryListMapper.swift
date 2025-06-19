//
//  CountryListMapper.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 27/05/25.
//

import Foundation

final class FlagListMapper {
    
    /// Maps a list of `FlagDTO` objects to an array of `Flag` domain models
    ///
    /// - Parameter dtoList: The list of data transfer objects received from the network layer
    /// - Returns: A mapped array of `Flag` objects ready for presentation or storage
    static func map(dtoList: [FlagDTO]) -> [Flag] {
        return dtoList.map { dto in
            Flag(
                name: dto.name.common,
                officialName: dto.name.official,
                code: dto.cca2,
                region: dto.region,
                flagImageURL: dto.flags.png ?? "",
                capital: dto.capital?.first ?? "Unknown"
            )
        }
    }
}
