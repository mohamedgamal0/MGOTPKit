//
//  OTPVerificationViewControllerBuilder.swift
//  MGOTPKit
//
//  Created by Ahmed Adel on 24/07/2025.
//

import Foundation

@MainActor
public class OTPVerificationViewControllerBuilder {
    public var config: OTPConfiguration = OTPConfiguration()
    public init() {}

    @discardableResult public func setDigitCount(_ v: Int) -> Self { config.digitCount = v; return self }
    @discardableResult public func setSpacing(_ v: CGFloat) -> Self { config.spacing = v; return self }
    @discardableResult public func setBorderColor(_ v: GenericColor) -> Self { config.borderColor = v; return self }
    @discardableResult public func setBorderWidth(_ v: CGFloat) -> Self { config.borderWidth = v; return self }
    @discardableResult public func setTextColor(_ v: GenericColor) -> Self { config.textColor = v; return self }
    @discardableResult public func setFont(_ v: GenericFont) -> Self { config.font = v; return self }
    @discardableResult public func setBackgroundColor(_ v: GenericColor) -> Self { config.backgroundColor = v; return self }
    @discardableResult public func setCornerRadius(_ v: CGFloat) -> Self { config.cornerRadius = v; return self }
    @discardableResult public func setFieldSize(_ v: CGSize) -> Self { config.fieldSize = v; return self }
    @discardableResult public func setAnimationDuration(_ v: Double) -> Self { config.animationDuration = v; return self }
    @discardableResult public func setCursorColor(_ v: GenericColor) -> Self { config.cursorColor = v; return self }
    @discardableResult public func setShapeType(_ v: ShapeType) -> Self { config.shapeType = v; return self }
    @discardableResult public func setErrorBorderColor(_ v: GenericColor) -> Self { config.errorBorderColor = v; return self }
    @discardableResult public func setOnCompletion(_ v: ((String) -> Void)?) -> Self { config.onCompletion = v; return self }

    @MainActor public func build() -> OTPVerificationViewController {
        OTPVerificationViewController(configuration: config)
    }
}

