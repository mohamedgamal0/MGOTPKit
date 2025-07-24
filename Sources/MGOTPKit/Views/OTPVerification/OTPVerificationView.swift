// OTPVerificationView.swift
// MGOTPKit
// Created by Mohamed Gamal on 10/11/2024

import SwiftUI

public struct OTPVerificationView: OTPVerificationViewProtocol {
        public init(
            digitCount: Int,
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
            errorBorderColor: Color,
            onCompletion: ((String) -> Void)?
        ) {
            self.digitCount = digitCount
            self.spacing = spacing
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

            let vm = OTPViewModel(
                borderColor: .swiftUIColor(borderColor),
                errorBorderColor: .swiftUIColor(errorBorderColor)
            )
            self.viewModel = vm

            _otpDigits = State(initialValue: Array(repeating: "", count: digitCount))
        }
        
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
            self.borderWidth = borderWidth
            self.textColor = textColor.toSwiftUIColor()
            self.font = font.toSwiftUIFont()
            self.backgroundColor = backgroundColor.toSwiftUIColor()
            self.cornerRadius = cornerRadius
            self.fieldSize = fieldSize
            self.animationDuration = animationDuration
            self.cursorColor = cursorColor.toSwiftUIColor()
            self.shapeType = shapeType
            self.onCompletion = onCompletion

            let vm = OTPViewModel(borderColor: borderColor, errorBorderColor: errorBorderColor)
            self.viewModel = vm

            _otpDigits = State(initialValue: Array(repeating: "", count: digitCount))
        }

    @State private var otpDigits: [String]
    @FocusState private var focusedField: Int?
    @ObservedObject public var viewModel: OTPViewModel

    public var digitCount: Int
    public var spacing: CGFloat
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

    public var body: some View {
        OTPContainerView(
            digitCount: digitCount,
            otpDigits: $otpDigits,
            focusedField: _focusedField,
            spacing: spacing,
            shapeType: shapeType,
            cornerRadius: cornerRadius,
            borderColor: viewModel.isError ? viewModel.errorBorderColor : viewModel.borderColor,
            borderWidth: borderWidth,
            fieldSize: fieldSize,
            textColor: textColor,
            font: font,
            cursorColor: cursorColor,
            onCompletion: onCompletion,
            onInputChange: handleInputChange
        )
        .onAppear {
            focusedField = 0
        }
    }

    private func handleInputChange(_ newValue: String, at index: Int) {
        if viewModel.isError {
            viewModel.isError = false
        }

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

    public func getCurrentOTP() -> String {
        otpDigits.joined()
    }

    public func clearFields() {
        otpDigits = Array(repeating: "", count: digitCount)
        focusedField = 0
    }

    public func setErrorState(_ error: Bool) {
        viewModel.isError = error
    }
}

