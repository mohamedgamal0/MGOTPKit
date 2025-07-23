//
//  OTPFieldView 2.swift
//  MGOTPKit
//
//  Created by MacBook Pro on 21/07/2025.
//


//
//  OTPFieldView.swift
//  MGOTPKit
//
//  Created by Mohamed Gamal on 10/11/2024.
//

import SwiftUI

struct OTPFieldView: View {
    var index: Int
    @Binding var otpDigits: [String]
    var focusedField: FocusState<Int?>.Binding
    var shapeType: ShapeType
    var cornerRadius: CGFloat
    @Binding var borderColor: Color // Changed to Binding
    var borderWidth: CGFloat
    var fieldSize: CGSize
    var textColor: Color
    var font: Font
    var cursorColor: Color
    var onChange: (String, Int) -> Void
    
    var body: some View {
        ZStack {
            shapeType.shape(with: cornerRadius)
                .fill(Color.white)
                .frame(width: fieldSize.width, height: fieldSize.height)
                .overlay(
                    shapeType.shape(with: cornerRadius)
                        .stroke(borderColor, lineWidth: borderWidth)
                )

            TextField("", text: $otpDigits[index])
                .focused(focusedField, equals: index)
                .multilineTextAlignment(.center)
                .foregroundColor(textColor)
                .font(font)
                .tint(cursorColor)
                .frame(width: fieldSize.width, height: fieldSize.height)
                .keyboardType(.numberPad)
                .onChange(of: otpDigits[index]) { newValue in
                    onChange(newValue, index)
                }
                .background(Color.clear)
        }
    }
}