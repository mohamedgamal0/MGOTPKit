//
//  GenericColor.swift
//  MGOTPKit
//
//  Created by Ahmed Adel on 24/07/2025.
//

import SwiftUI

public enum GenericColor: Sendable {
    case uiColor(UIColor)
    case swiftUIColor(Color)
    
    func toSwiftUIColor() -> Color {
        switch self {
        case .uiColor(let uiColor):
            return Color(uiColor)
        case .swiftUIColor(let color):
            return color
        }
    }
}

