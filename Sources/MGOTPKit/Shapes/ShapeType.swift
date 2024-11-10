//
//  ShapeType.swift
//  MGOTPKit
//
//  Created by Mohamed Gamal on 10/11/2024.
//

import SwiftUI

@frozen public enum ShapeType {
    case roundedRectangle(cornerRadius: CGFloat)
    case circle
    case capsule

    /// Returns the corresponding `ShapeAdapter` for the given shape type.
    public func shape(with cornerRadius: CGFloat) -> ShapeAdapter {
        switch self {
        case .roundedRectangle(let cornerRadius):
            return ShapeAdapter(shape: RoundedRectangle(cornerRadius: cornerRadius))
        case .circle:
            return ShapeAdapter(shape: Circle())
        case .capsule:
            return ShapeAdapter(shape: Capsule())
        }
    }
}
