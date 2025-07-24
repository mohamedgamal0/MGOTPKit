//
//  GenericFont.swift
//  MGOTPKit
//
//  Created by Ahmed Adel on 24/07/2025.
//

import Foundation
import SwiftUI

public enum GenericFont: Sendable {
    case uiFont(UIFont)
    case swiftUIFont(Font)
    
    func toSwiftUIFont() -> Font {
        switch self {
        case .uiFont(let uiFont):
            return Font(uiFont)
        case .swiftUIFont(let font):
            return font
        }
    }
}
