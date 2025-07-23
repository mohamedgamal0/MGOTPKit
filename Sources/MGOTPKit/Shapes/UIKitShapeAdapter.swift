//
//  UIKitShapeAdapter.swift
//  MGOTPKit
//
//  Created by Mohamed Gamal on 10/11/2024.
//

import UIKit
import SwiftUI

public final class UIKitShapeAdapter: UIView {
    private let _path: @Sendable (CGRect) -> UIBezierPath

    public init<S: Shape>(shape: S) {
        // Capture the shape's path function and mark it as @Sendable
        self._path = { rect in
            let path = shape.path(in: rect)
            return UIBezierPath(cgPath: path.cgPath)
        }
        super.init(frame: .zero)
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        let path = _path(rect)
        path.stroke()
    }
}
