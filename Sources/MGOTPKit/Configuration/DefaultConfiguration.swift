//
//  DefaultConfiguration.swift
//  MGOTPKit
//
//  Created by Mohamed Gamal on 10/11/2024.
//

import Foundation
import SwiftUI

/// Default configurations for OTPVerificationView.
public struct DefaultConfiguration {
    public static let digitCount: Int = 6
    public static let spacing: CGFloat = 8
    public static let borderColor: Color = .gray
    public static let borderWidth: CGFloat = 1
    public static let textColor: Color = .black
    public static let font: Font = .system(size: 16, weight: .medium)
    public static let backgroundColor: Color = .white
    public static let cornerRadius: CGFloat = 8
    public static let fieldSize: CGSize = CGSize(width: 40, height: 40)
    public static let animationDuration: Double = 0.3
    public static let cursorColor: Color = .blue
    public static let shapeType: ShapeType = .roundedRectangle(cornerRadius: 8)
}
