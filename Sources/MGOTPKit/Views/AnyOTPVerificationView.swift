//
//  AnyOTPVerificationView.swift
//  MGOTPKit
//
//  Created by Ahmed Adel on 24/07/2025.
//

import SwiftUI
public struct AnyOTPVerificationView: View {
    private let _body: AnyView
    public init<V: OTPVerificationViewProtocol>(_ view: V) {
        self._body = AnyView(view)
    }
    public var body: some View { _body }
}
