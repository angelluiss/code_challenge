//
//  CountryListDTO.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 27/05/25.
//

import Foundation

// MARK: - FlagDTO
public struct FlagDTO: Codable {
    let name: NameDTO
    let tld: [String]?
    let cca2: String
    let cioc: String?
    let independent: Bool
    let status: String
    let currencies: [String: CurrencyDTO]?
    let capital: [String]?
    let region: String
    let subregion: String?
    let languages: [String: String]?
    let latlng: [Double]
    let borders: [String]?
    let area: Double
    let translations: [String: TranslationDTO]
    let flags: ImageDTO
}

// MARK: - NameDTO
struct NameDTO: Codable {
    let common: String
    let official: String
    let nativeName: [String: TranslationDTO]?
}

// MARK: - CurrencyDTO
struct CurrencyDTO: Codable {
    let symbol: String
    let name: String
}

// MARK: - TranslationDTO
struct TranslationDTO: Codable {
    let official: String
    let common: String
}

// MARK: - CarDTO
struct CarDTO: Codable {
    let signs: [String]?
    let side: String
}

// MARK: - MapsDTO
struct MapsDTO: Codable {
    let googleMaps: String
    let openStreetMaps: String
}

// MARK: - ImageDTO
struct ImageDTO: Codable {
    let png: String?
    let svg: String?
    let alt: String?
}

// MARK: - CapitalInfoDTO
struct CapitalInfoDTO: Codable {
    let latlng: [Double]?
}

// MARK: - PostalCodeDTO
struct PostalCodeDTO: Codable {
    let format: String?
    let regex: String?
}
