//
//  OTPContainerView.swift
//  MGOTPKit
//
//  Created by Mohamed Gamal on 10/11/2024.
//

import SwiftUI

struct OTPContainerView: View {
    var digitCount: Int
    @Binding var otpDigits: [String]
    @FocusState var focusedField: Int?
    
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
    
    var onInputChange: (String, Int) -> Void

    var body: some View {
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
                             onChange: onInputChange)
            }
        }
        .onAppear {
            focusedField = 0
        }
    }
}
