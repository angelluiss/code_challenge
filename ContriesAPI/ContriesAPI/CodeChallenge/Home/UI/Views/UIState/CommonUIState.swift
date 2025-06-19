//
//  CommonUIState.swift
//  ContriesAPI
//
//  Created by Angel Gabriel Rangel Pinero on 30/05/25.
//

import Foundation

/// A common UI state enum used to represent the different loading states of a view
enum CommonUIState {
    
    /// The initial state before any action is taken
    case idle
    
    /// The state representing an ongoing loading operation
    case loading
    
    /// The state representing successful data retrieval
    /// - Parameter country: The successfully loaded `CountryDetail` model
    case success(CountryDetail)
    
    /// The state representing a failure, with an associated error
    /// - Parameter error: The error encountered during the operation
    case failure(Error)
}
