//
//  OTPViewModel.swift
//  MGOTPKit
//
//  Created by Ahmed Adel on 24/07/2025.
//

import SwiftUI
public class OTPViewModel: ObservableObject {
    @Published public var isError: Bool = false
    @Published public var borderColor: Color
    @Published public var errorBorderColor: Color
    
    public init(borderColor: GenericColor, errorBorderColor: GenericColor) {
        self.borderColor = borderColor.toSwiftUIColor()
        self.errorBorderColor = errorBorderColor.toSwiftUIColor()
    }
}
