//
//  ShapeAdapter.swift
//  MGOTPKit
//
//  Created by Mohamed Gamal on 10/11/2024.
//

import SwiftUI

/// A wrapper that allows different types of shapes to be used interchangeably.
public final class ShapeAdapter: Shape, Sendable {
    private let _path: @Sendable (CGRect) -> Path

    public init<S: Shape>(shape: S) {
        // Capture the shape's path function and mark it as @Sendable
        self._path = { rect in shape.path(in: rect) }
    }

    public func path(in rect: CGRect) -> Path {
        _path(rect)
    }
}
