//
//  OTPVerificationView.swift
//  MGOTPKit
//
//  Created by Mohamed Gamal on 10/11/2024.
//

import SwiftUI

// MARK: ViewModel for error state
public class OTPViewModel: ObservableObject {
    @Published public var isError: Bool = false
    @Published public var borderColor: Color = .gray
    @Published public var errorBorderColor: Color = .red
    
    public init(borderColor: Color = .gray, errorBorderColor: Color = .red) {
        self.borderColor = borderColor
        self.errorBorderColor = errorBorderColor
    }
}

// MARK: Main OTP Verification View
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

        let vm = OTPViewModel(borderColor: borderColor, errorBorderColor: .red)
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

    // MARK: Initializer
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
        errorBorderColor: Color = .red,
        onCompletion: ((String) -> Void)? = nil
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

        let vm = OTPViewModel(borderColor: borderColor, errorBorderColor: errorBorderColor)
        self.viewModel = vm

        _otpDigits = State(initialValue: Array(repeating: "", count: digitCount))
    }

    // MARK: Body
    @MainActor public var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<digitCount, id: \.self) { index in
                OTPFieldView(
                    index: index,
                    otpDigits: $otpDigits,
                    focusedField: $focusedField,
                    shapeType: shapeType,
                    cornerRadius: cornerRadius,
                    borderColor: viewModel.isError ? viewModel.errorBorderColor : viewModel.borderColor,
                    borderWidth: borderWidth,
                    fieldSize: fieldSize,
                    textColor: textColor,
                    font: font,
                    cursorColor: cursorColor,
                    onChange: handleInputChange
                )
                .animation(.easeInOut(duration: animationDuration), value: viewModel.isError)
            }
        }
        .onAppear {
            focusedField = 0
        }
    }

    // MARK: Handle Input
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

    // MARK: Public Methods
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

// MARK: Protocol
public protocol OTPVerificationViewProtocol: View {
    init(
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
        onCompletion: ((String) -> Void)?
    )
}

// MARK: Type Eraser
public struct AnyOTPVerificationView: View {
    private let _body: AnyView
    public init<V: OTPVerificationViewProtocol>(_ view: V) {
        self._body = AnyView(view)
    }
    public var body: some View { _body }
}

// MARK: Builder
public class OTPVerificationViewControllerBuilder {
    public var config: OTPConfiguration = OTPConfiguration()
    public init() {}

    @discardableResult public func setDigitCount(_ v: Int) -> Self { config.digitCount = v; return self }
    @discardableResult public func setSpacing(_ v: CGFloat) -> Self { config.spacing = v; return self }
    @discardableResult public func setBorderColor(_ v: Color) -> Self { config.borderColor = v; return self }
    @discardableResult public func setBorderWidth(_ v: CGFloat) -> Self { config.borderWidth = v; return self }
    @discardableResult public func setTextColor(_ v: Color) -> Self { config.textColor = v; return self }
    @discardableResult public func setFont(_ v: Font) -> Self { config.font = v; return self }
    @discardableResult public func setBackgroundColor(_ v: Color) -> Self { config.backgroundColor = v; return self }
    @discardableResult public func setCornerRadius(_ v: CGFloat) -> Self { config.cornerRadius = v; return self }
    @discardableResult public func setFieldSize(_ v: CGSize) -> Self { config.fieldSize = v; return self }
    @discardableResult public func setAnimationDuration(_ v: Double) -> Self { config.animationDuration = v; return self }
    @discardableResult public func setCursorColor(_ v: Color) -> Self { config.cursorColor = v; return self }
    @discardableResult public func setShapeType(_ v: ShapeType) -> Self { config.shapeType = v; return self }
    @discardableResult public func setErrorBorderColor(_ v: Color) -> Self { config.errorBorderColor = v; return self }
    @discardableResult public func setOnCompletion(_ v: ((String) -> Void)?) -> Self { config.onCompletion = v; return self }

    @MainActor public func build() -> OTPVerificationViewController {
        OTPVerificationViewController(configuration: config)
    }
}
