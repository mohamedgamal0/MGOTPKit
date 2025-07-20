//
//  DefaultConfiguration.swift
//  MGOTPKit
//
//  Created by Mohamed Gamal on 10/11/2024.
//

import Foundation
import SwiftUI

/// Default configurations for OTPVerificationView.
public struct DefaultConfiguration {
    public static let digitCount: Int = 6
    public static let spacing: CGFloat = 8
    public static let borderColor: Color = .gray
    public static let borderWidth: CGFloat = 1
    public static let textColor: Color = .black
    public static let font: Font = .system(size: 16, weight: .medium)
    public static let backgroundColor: Color = .white
    public static let cornerRadius: CGFloat = 8
    public static let fieldSize: CGSize = CGSize(width: 40, height: 40)
    public static let animationDuration: Double = 0.3
    public static let cursorColor: Color = .blue
    public static let shapeType: ShapeType = .roundedRectangle(cornerRadius: 8)
}
/// Configuration for OTPVerificationViewController.
public struct OTPConfiguration {
    public var digitCount: Int
    public var spacing: CGFloat
    public var borderColor: Color
    public var borderWidth: CGFloat
    public var textColor: Color
    public var font: Font
    public var backgroundColor: Color
    public var cornerRadius: CGFloat
    public var fieldSize: CGSize
    public var animationDuration: Double
    public var cursorColor: Color
    public var shapeType: ShapeType
    public var onCompletion: ((String) -> Void)?

    public init(
        digitCount: Int = DefaultConfiguration.digitCount,
        spacing: CGFloat = DefaultConfiguration.spacing,
        borderColor: Color = DefaultConfiguration.borderColor,
        borderWidth: CGFloat = DefaultConfiguration.borderWidth,
        textColor: Color = DefaultConfiguration.textColor,
        font: Font = DefaultConfiguration.font,
        backgroundColor: Color = DefaultConfiguration.backgroundColor,
        cornerRadius: CGFloat = DefaultConfiguration.cornerRadius,
        fieldSize: CGSize = DefaultConfiguration.fieldSize,
        animationDuration: Double = DefaultConfiguration.animationDuration,
        cursorColor: Color = DefaultConfiguration.cursorColor,
        shapeType: ShapeType = DefaultConfiguration.shapeType,
        onCompletion: ((String) -> Void)? = nil
    ) {
        self.digitCount = digitCount
        self.spacing = spacing
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.textColor = textColor
        self.font = font
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.fieldSize = fieldSize
        self.animationDuration = animationDuration
        self.cursorColor = cursorColor
        self.shapeType = shapeType
        self.onCompletion = onCompletion
    }
}
