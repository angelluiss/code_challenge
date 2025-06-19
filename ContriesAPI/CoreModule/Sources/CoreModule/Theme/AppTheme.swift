//
//  AppTheme.swift
//  CoreModule
//
//  Created by Angel Rangel on 14/01/25.
//

import SwiftUI

/// A namespace containing design constants for the application, such as colors and dimensions
public struct AppTheme {
    
    /// A set of named colors used throughout the application
    public struct Color {
        
        /// The primary background color
        public static let primaryBackground = SwiftUI.Color("PrimaryBackground")
        
        /// The secondary background color
        public static let secondaryBackground = SwiftUI.Color("SecondaryBackground")
        
        /// The primary text color
        public static let primaryText = SwiftUI.Color("PrimaryText")
        
        /// The secondary text color
        public static let secondaryText = SwiftUI.Color("SecondaryText")
    }
    
    /// A set of layout and typography constants for consistent spacing and sizing
    @MainActor
    public struct Dimension {
        
        /// Small padding (6 pts)
        public static let paddingS: CGFloat = 6.0
        
        /// Default padding (16 pts)
        public static let padding: CGFloat = 16.0
        
        /// Extra-large padding (22 pts)
        public static let paddingXL: CGFloat = 22.0
        
        /// Double extra-large padding (42 pts)
        public static let paddingXXL: CGFloat = 42.0
        
        /// Default corner radius for UI elements (8 pts)
        public static let cornerRadius: CGFloat = 8.0
        
        /// Font size for titles (24 pts)
        public static let titleFontSize: CGFloat = 24.0
        
        /// Font size for body text (16 pts)
        public static let bodyFontSize: CGFloat = 16.0
        
        /// Standard image width (80 pts)
        public static let widthImage: CGFloat = 80.0
        
        /// Small image width (40 pts)
        public static let widthImageS: CGFloat = 40.0
        
        /// Maximum image width, based on the device's screen width
        public static var widthImageMax: CGFloat {
            UIScreen.main.bounds.width
        }
    }
}
