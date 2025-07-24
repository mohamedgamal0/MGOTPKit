//
//  OTPVerificationViewProtocol.swift
//  MGOTPKit
//
//  Created by Ahmed Adel on 24/07/2025.
//

import SwiftUI
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
        errorBorderColor: Color,
        onCompletion: ((String) -> Void)?
    )
}
