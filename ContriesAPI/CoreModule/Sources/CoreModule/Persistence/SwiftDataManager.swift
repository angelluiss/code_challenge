//
//  SwiftDataManager.swift
//  CoreModule
//
//  Created by Angel Gabriel Rangel Pinero on 30/05/25.
//

import Foundation
import SwiftData

/// A model representing a favorite country stored using SwiftData
@available(iOS 17, *)
@Model
public class FavoriteCountry {
    
    /// The common name of the country
    public var name: String? = ""
    
    /// The official name of the country
    public var officialName: String? = ""
    
    /// The URL string pointing to the country's flag image
    public var flagImageURL: String? = ""
    
    /// The capital city of the country
    public var capital: String? = ""

    /// Initializes a new instance of `FavoriteCountry`
    ///
    /// - Parameters:
    ///   - name: The common name of the country
    ///   - officialName: The official name of the country
    ///   - flagImageURL: The URL to the country's flag image
    ///   - capital: The capital city of the country
    public init(name: String? = nil, officialName: String? = nil, flagImageURL: String? = nil, capital: String? = nil) {
        self.name = name
        self.officialName = officialName
        self.flagImageURL = flagImageURL
        self.capital = capital
    }
}
