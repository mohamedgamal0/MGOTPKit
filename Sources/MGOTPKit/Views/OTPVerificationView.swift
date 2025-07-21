//
//  OTPVerificationView.swift
//  MGOTPKit
//
//  Created by Mohamed Gamal on 10/11/2024.
//

import SwiftUI


public struct OTPVerificationView: OTPVerificationViewProtocol {
    @State private var otpDigits: [String]
    @FocusState private var focusedField: Int?
    public var onChange: ((String) -> Void)?

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
    
    public init(digitCount: Int = DefaultConfiguration.digitCount,
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
                onCompletion: ((String) -> Void)? = nil,
                onChange: ((String) -> Void)? = nil) {
        
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
        self.onChange = onChange
        _otpDigits = State(initialValue: Array(repeating: "", count: digitCount))
    }
    
    @MainActor public var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<digitCount, id: \.self) { index in
                OTPFieldView(index: index,
                             otpDigits: $otpDigits,
                             focusedField: $focusedField,
                             shapeType: shapeType,
                             cornerRadius: cornerRadius,
                             borderColor: borderColor,
                             borderWidth: borderWidth,
                             fieldSize: fieldSize,
                             textColor: textColor,
                             font: font,
                             cursorColor: cursorColor,
                             onChange: handleInputChange)
            }
        }
        .onAppear {
            focusedField = 0
        }
    }
    
    private func handleInputChange(_ newValue: String, at index: Int) {
        otpDigits[index] = String(newValue.prefix(1))
        
        if !newValue.isEmpty && index < digitCount - 1 {
            focusedField = index + 1
        } else if newValue.isEmpty && index > 0 {
            focusedField = index - 1
        }
        
        let currentOTP = otpDigits.joined()
        onChange?(currentOTP)
        if currentOTP.count == digitCount {
            onCompletion?(currentOTP)
        }
    }
}

public protocol OTPVerificationViewProtocol: View {
    init(digitCount: Int,
         spacing: CGFloat,
         borderColor: Color,
         borderWidth: CGFloat,
         textColor: Color,
         font: Font,
         backgroundColor: Color,
         cornerRadius: CGFloat,
         fieldSize: CGSize,
         animationDuration: Double,
         cursorColor: Color,
         shapeType: ShapeType,
         onCompletion: ((String) -> Void)?,
         onChange: ((String) -> Void)?)
}

public struct AnyOTPVerificationView: View {
    private let _body: AnyView
    
    public init<V: OTPVerificationViewProtocol>(_ view: V) {
        self._body = AnyView(view)
    }
    
    public var body: some View {
        _body
    }
}

//MARK: Builder
public class OTPVerificationViewControllerBuilder {
    private var config = OTPConfiguration()

    public init() {}

    @discardableResult public func setDigitCount(_ value: Int) -> Self {
        config.digitCount = value
        return self
    }

    @discardableResult public func setSpacing(_ value: CGFloat) -> Self {
        config.spacing = value
        return self
    }

    @discardableResult public func setBorderColor(_ value: Color) -> Self {
        config.borderColor = value
        return self
    }

    @discardableResult public func setBorderWidth(_ value: CGFloat) -> Self {
        config.borderWidth = value
        return self
    }

    @discardableResult public func setTextColor(_ value: Color) -> Self {
        config.textColor = value
        return self
    }

    @discardableResult public func setFont(_ value: Font) -> Self {
        config.font = value
        return self
    }

    @discardableResult public func setBackgroundColor(_ value: Color) -> Self {
        config.backgroundColor = value
        return self
    }

    @discardableResult public func setCornerRadius(_ value: CGFloat) -> Self {
        config.cornerRadius = value
        return self
    }

    @discardableResult public func setFieldSize(_ value: CGSize) -> Self {
        config.fieldSize = value
        return self
    }

    @discardableResult public func setAnimationDuration(_ value: Double) -> Self {
        config.animationDuration = value
        return self
    }

    @discardableResult public func setCursorColor(_ value: Color) -> Self {
        config.cursorColor = value
        return self
    }

    @discardableResult public func setShapeType(_ value: ShapeType) -> Self {
        config.shapeType = value
        return self
    }

    @discardableResult public func setOnCompletion(_ handler: ((String) -> Void)?) -> Self {
        config.onCompletion = handler
        return self
    }

    @discardableResult public func setOnChange(_ handler: ((String) -> Void)?) -> Self {
        config.onChange = handler
        return self
    }

    @MainActor public func build() -> OTPVerificationViewController {
        return OTPVerificationViewController(configuration: config)
    }
}
