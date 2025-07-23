//
//  OTPContainerView.swift
//  MGOTPKit
//
//  Created by Mohamed Gamal on 10/11/2024.
//

import SwiftUI

struct OTPContainerView: View {
    let digitCount: Int
    @Binding var otpDigits: [String]
    @FocusState private var focusedField: Int?

    var spacing: CGFloat
    var shapeType: ShapeType
    var cornerRadius: CGFloat
    var borderColor: Color
    var borderWidth: CGFloat
    var fieldSize: CGSize
    var textColor: Color
    var font: Font
    var cursorColor: Color
    var onCompletion: ((String) -> Void)?
    var onChange: ((String) -> Void)?

    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<digitCount, id: \.self) { index in
                OTPFieldView(
                    index: index,
                    otpDigits: $otpDigits,
                    focusedField: $focusedField,
                    shapeType: shapeType,
                    cornerRadius: cornerRadius,
                    borderColor: borderColor,
                    borderWidth: borderWidth,
                    fieldSize: fieldSize,
                    textColor: textColor,
                    font: font,
                    cursorColor: cursorColor
                ) { digit, i in
                    otpDigits[i] = digit
                    handleFocusChange(for: digit, at: i)

                    let currentOTP = otpDigits.joined()
                    onChange?(currentOTP)
                    if currentOTP.filter(\.isNumber).count == digitCount {
                        onCompletion?(currentOTP)
                    }
                }
            }
        }
        .onAppear {
            focusedField = 0
        }
    }

    private func handleFocusChange(for digit: String, at index: Int) {
        if digit.isEmpty {
            // Move back if deleted
            if index > 0 {
                focusedField = index - 1
            }
        } else {
            // Move forward if typed
            if index < digitCount - 1 {
                focusedField = index + 1
            }
        }
    }
}
