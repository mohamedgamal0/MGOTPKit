// DefaultConfiguration.swift
// MGOTPKit
// Created by Mohamed Gamal on 10/11/2024

import Foundation
import UIKit

public struct DefaultConfiguration {
    @MainActor public static let digitCount: Int = 6
    @MainActor public static let spacing: CGFloat = 8
    @MainActor public static let borderColor: GenericColor = .uiColor(.gray)
    @MainActor public static let borderWidth: CGFloat = 1
    @MainActor public static let textColor: GenericColor = .uiColor(.black)
    @MainActor public static let font: GenericFont = .uiFont(.systemFont(ofSize: 16, weight: .medium))
    @MainActor public static let backgroundColor: GenericColor = .uiColor(.white)
    @MainActor public static let cornerRadius: CGFloat = 8
    @MainActor public static let fieldSize: CGSize = CGSize(width: 40, height: 40)
    @MainActor public static let animationDuration: Double = 0.3
    @MainActor public static let cursorColor: GenericColor = .uiColor(.blue)
    @MainActor public static let shapeType: ShapeType = .roundedRectangle(cornerRadius: 8)
    @MainActor public static let errorBorderColor: GenericColor = .uiColor(.red)
}

public struct OTPConfiguration {
    public var digitCount: Int
    public var spacing: CGFloat
    public var borderColor: GenericColor
    public var borderWidth: CGFloat
    public var textColor: GenericColor
    public var font: GenericFont
    public var backgroundColor: GenericColor
    public var cornerRadius: CGFloat
    public var fieldSize: CGSize
    public var animationDuration: Double
    public var cursorColor: GenericColor
    public var shapeType: ShapeType
    public var errorBorderColor: GenericColor
    public var onCompletion: ((String) -> Void)?

    @MainActor
    public init(
        digitCount: Int = DefaultConfiguration.digitCount,
        spacing: CGFloat = DefaultConfiguration.spacing,
        borderColor: GenericColor = DefaultConfiguration.borderColor,
        borderWidth: CGFloat = DefaultConfiguration.borderWidth,
        textColor: GenericColor = DefaultConfiguration.textColor,
        font: GenericFont = DefaultConfiguration.font,
        backgroundColor: GenericColor = DefaultConfiguration.backgroundColor,
        cornerRadius: CGFloat = DefaultConfiguration.cornerRadius,
        fieldSize: CGSize = DefaultConfiguration.fieldSize,
        animationDuration: Double = DefaultConfiguration.animationDuration,
        cursorColor: GenericColor = DefaultConfiguration.cursorColor,
        shapeType: ShapeType = DefaultConfiguration.shapeType,
        errorBorderColor: GenericColor = DefaultConfiguration.errorBorderColor,
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
        self.errorBorderColor = errorBorderColor
        self.onCompletion = onCompletion
    }
}
