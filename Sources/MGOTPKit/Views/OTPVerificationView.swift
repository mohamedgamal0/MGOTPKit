//
//  OTPVerificationView.swift
//  MGOTPKit
//
//  Created by Mohamed Gamal on 10/11/2024.
//

import SwiftUI


public struct OTPVerificationView: View {
    @State private var otpDigits: [String]
    @FocusState private var focusedField: Int?
    
    // Customization properties
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
