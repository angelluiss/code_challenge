//
//  CountryDetailDTO.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 27/05/25.
//

import Foundation

// MARK: - CountryDetailElement
public struct CountryDetailElement: Codable {
    let name: Name
    let tld: [String]
    let independent: Bool
    let status: String
    let currencies: Currencies
    let idd: Idd
    let capital, altSpellings: [String]
    let region, subregion: String?
    let languages: Languages
    let area: Double
    let cca3: String
    let translations: [String: Translation]
    let flag: String
    let maps: Maps
    let population: Int
    let car: Car
    let timezones, continents: [String]
    let flags: Flags
    let coatOfArms: CoatOfArms?
    let capitalInfo: CapitalInfo?
    
    init(
        name: Name,
        tld: [String],
        independent: Bool,
        status: String,
        currencies: Currencies,
        idd: Idd,
        capital: [String],
        altSpellings: [String],
        region: String?,
        subregion: String?,
        languages: Languages,
        area: Double,
        cca3: String,
        translations: [String: Translation],
        flag: String,
        maps: Maps,
        population: Int,
        car: Car,
        timezones: [String],
        continents: [String],
        flags: Flags,
        coatOfArms: CoatOfArms,
        capitalInfo: CapitalInfo
    ) {
        self.name = name
        self.tld = tld
        self.independent = independent
        self.status = status
        self.currencies = currencies
        self.idd = idd
        self.capital = capital
        self.altSpellings = altSpellings
        self.region = region
        self.subregion = subregion
        self.languages = languages
        self.area = area
        self.cca3 = cca3
        self.translations = translations
        self.flag = flag
        self.maps = maps
        self.population = population
        self.car = car
        self.timezones = timezones
        self.continents = continents
        self.flags = flags
        self.coatOfArms = coatOfArms
        self.capitalInfo = capitalInfo
    }

    
    enum CodingKeys: String, CodingKey {
         case name, tld, independent, status, currencies, idd, capital, altSpellings, region, subregion, languages, area, cca3, translations, flag, maps, population, car, timezones, continents, flags, coatOfArms, capitalInfo
     }

     public init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: CodingKeys.self)

         self.name = try container.decode(Name.self, forKey: .name)
         self.tld = try container.decode([String].self, forKey: .tld)
         self.independent = try container.decode(Bool.self, forKey: .independent)
         self.status = try container.decode(String.self, forKey: .status)
         self.currencies = try container.decode(Currencies.self, forKey: .currencies)
         self.idd = try container.decode(Idd.self, forKey: .idd)
         self.capital = try container.decode([String].self, forKey: .capital)
         self.altSpellings = try container.decode([String].self, forKey: .altSpellings)
         self.region = try container.decodeIfPresent(String.self, forKey: .region)
         self.subregion = try container.decodeIfPresent(String.self, forKey: .subregion)
         self.languages = try container.decode(Languages.self, forKey: .languages)
         self.area = try {
             if let doubleValue = try? container.decode(Double.self, forKey: .area) {
                 return doubleValue
             } else if let intValue = try? container.decode(Int.self, forKey: .area) {
                 return Double(intValue)
             } else {
                 throw DecodingError.typeMismatch(Double.self, DecodingError.Context(
                     codingPath: [CodingKeys.area],
                     debugDescription: "Expected Double or Int for area."
                 ))
             }
         }()
         self.cca3 = try container.decode(String.self, forKey: .cca3)
         self.translations = try container.decode([String: Translation].self, forKey: .translations)
         self.flag = try container.decode(String.self, forKey: .flag)
         self.maps = try container.decode(Maps.self, forKey: .maps)
         self.population = try container.decode(Int.self, forKey: .population)
         self.car = try container.decode(Car.self, forKey: .car)
         self.timezones = try container.decode([String].self, forKey: .timezones)
         self.continents = try container.decode([String].self, forKey: .continents)
         self.flags = try container.decode(Flags.self, forKey: .flags)
         self.coatOfArms = try container.decode(CoatOfArms?.self, forKey: .coatOfArms)
         self.capitalInfo = try container.decode(CapitalInfo.self, forKey: .capitalInfo)
     }
}

// MARK: - CapitalInfo
struct CapitalInfo: Codable {
    let latlng: [Double]?
}

// MARK: - Car
struct Car: Codable {
    let signs: [String]
    let side: String
}

// MARK: - CoatOfArms
struct CoatOfArms: Codable {
    let png: String?
    let svg: String?
}

// MARK: - Currencies
struct Currencies: Codable {
    let values: [String: Currency]

    struct Currency: Codable {
        let name: String
        let symbol: String
    }

    var firstCurrency: Currency? {
        values.values.first
    }
    
    init(values: [String: Currencies.Currency]) {
        self.values = values
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.values = try container.decode([String: Currency].self)
    }
}

// MARK: - Flags
struct Flags: Codable {
    let png: String
    let svg: String
    let alt: String?
}


// MARK: - Idd
struct Idd: Codable {
    let root: String
    let suffixes: [String]
}

// MARK: - Languages
struct Languages: Codable {
    let values: [String: String]

    var primaryLanguage: String? {
        values.values.first
    }
    
    init(values: [String: String]) {
        self.values = values
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.values = try container.decode([String: String].self)
    }
}

// MARK: - Maps
struct Maps: Codable {
    let googleMaps, openStreetMaps: String
}

// MARK: - Name
struct Name: Codable {
    let common, official: String
    let nativeName: NativeName
}

// MARK: - NativeName
struct NativeName: Codable {
    let values: [String: Translation]

    var firstTranslation: Translation? {
        values.values.first
    }
    
    init(values: [String: Translation]) {
        self.values = values
    }
    
    enum CodingKeys: CodingKey {
        case values
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.values = try container.decode([String: Translation].self)
    }
}

// MARK: - Translation
struct Translation: Codable {
    let official, common: String
}

private struct RawNumber: Decodable {
    let value: Double

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let double = try? container.decode(Double.self) {
            value = double
        } else if let int = try? container.decode(Int.self) {
            value = Double(int)
        } else {
            throw DecodingError.typeMismatch(Double.self, DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "Expected Double or Int for coordinate"
            ))
        }
    }
}
