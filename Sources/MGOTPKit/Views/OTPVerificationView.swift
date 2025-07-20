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
                onCompletion: ((String) -> Void)? = nil) {
        
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
        
        if otpDigits.joined().count == digitCount {
            onCompletion?(otpDigits.joined())
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
         onCompletion: ((String) -> Void)?)
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
    private var config: OTPConfiguration
    
    public init() {
        self.config = OTPConfiguration()
    }
    
    @discardableResult
    public func setDigitCount(_ digitCount: Int) -> Self {
        config.digitCount = digitCount
        return self
    }
    
    @discardableResult
    public func setSpacing(_ spacing: CGFloat) -> Self {
        config.spacing = spacing
        return self
    }
    
    @discardableResult
    public func setBorderColor(_ borderColor: Color) -> Self {
        config.borderColor = borderColor
        return self
    }
    
    @discardableResult
    public func setBorderWidth(_ borderWidth: CGFloat) -> Self {
        config.borderWidth = borderWidth
        return self
    }
    
    @discardableResult
    public func setTextColor(_ textColor: Color) -> Self {
        config.textColor = textColor
        return self
    }
    
    @discardableResult
    public func setFont(_ font: Font) -> Self {
        config.font = font
        return self
    }
    
    @discardableResult
    public func setBackgroundColor(_ backgroundColor: Color) -> Self {
        config.backgroundColor = backgroundColor
        return self
    }
    
    @discardableResult
    public func setCornerRadius(_ cornerRadius: CGFloat) -> Self {
        config.cornerRadius = cornerRadius
        return self
    }
    
    @discardableResult
    public func setFieldSize(_ fieldSize: CGSize) -> Self {
        config.fieldSize = fieldSize
        return self
    }
    
    @discardableResult
    public func setAnimationDuration(_ animationDuration: Double) -> Self {
        config.animationDuration = animationDuration
        return self
    }
    
    @discardableResult
    public func setCursorColor(_ cursorColor: Color) -> Self {
        config.cursorColor = cursorColor
        return self
    }
    
    @discardableResult
    public func setShapeType(_ shapeType: ShapeType) -> Self {
        config.shapeType = shapeType
        return self
    }
    
    @discardableResult
    public func setOnCompletion(_ handler: ((String) -> Void)?) -> Self {
        config.onCompletion = handler
        return self
    }
    
    @MainActor public func build() -> OTPVerificationViewController {
        OTPVerificationViewController(configuration: config)
    }
}
    
