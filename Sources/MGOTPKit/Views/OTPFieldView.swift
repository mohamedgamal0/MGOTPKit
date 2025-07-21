//
//  OTPFieldView.swift
//  MGOTPKit
//
//  Created by Mohamed Gamal on 10/11/2024.
//

import SwiftUI

/// OTP field view to represent each digit input field.
struct OTPFieldView: View {
    var index: Int
    @Binding var otpDigits: [String]
    var focusedField: FocusState<Int?>.Binding
    var shapeType: ShapeType
    var cornerRadius: CGFloat
    var borderColor: Color
    var borderWidth: CGFloat
    var fieldSize: CGSize
    var textColor: Color
    var font: Font
    var cursorColor: Color
    var onChange: (String, Int) -> Void

    @State private var internalText: String = ""

    var body: some View {
        ZStack {
            shapeType.shape(with: cornerRadius)
                .fill(Color.white)
                .frame(width: fieldSize.width, height: fieldSize.height)
                .overlay(
                    shapeType.shape(with: cornerRadius)
                        .stroke(borderColor, lineWidth: borderWidth)
                )

            TextField("", text: $internalText)
                .focused(focusedField, equals: index)
                .multilineTextAlignment(.center)
                .foregroundColor(textColor)
                .font(font)
                .tint(cursorColor)
                .frame(width: fieldSize.width, height: fieldSize.height)
                .keyboardType(.numberPad)
                .onChange(of: internalText) { newValue in
                    let digit = newValue.last.map { String($0) } ?? ""
                    otpDigits[index] = digit
                    onChange(digit, index)
                    // Reset field to single character max
                    internalText = digit
                }
                .background(Color.clear)
                .onAppear {
                    updateInternalText()
                }
                .onChange(of: otpDigits[index]) { _ in
                    updateInternalText()
                }
        }
    }

    private func updateInternalText() {
        internalText = otpDigits[index].isEmpty ? "-" : otpDigits[index]
    }
}
