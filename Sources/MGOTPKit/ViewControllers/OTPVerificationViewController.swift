//
//  File.swift
//  MGOTPKit
//
//  Created by Mohamed Gamal on 10/11/2024.
//

import SwiftUI
import UIKit

// UIKit wrapper for OTPVerificationView
public class OTPVerificationViewController: UIViewController {
    private var otpVerificationView: OTPVerificationView

    public init(digitCount: Int = DefaultConfiguration.digitCount,
                spacing: CGFloat = DefaultConfiguration.spacing,
                borderColor: Color = DefaultConfiguration.borderColor,
                borderWidth: CGFloat = DefaultConfiguration.borderWidth,
                textColor: Color = DefaultConfiguration.textColor,
                font: Font = DefaultConfiguration.font,
                backgroundColor: Color = DefaultConfiguration.backgroundColor,
                cornerRadius: CGFloat = DefaultConfiguration.cornerRadius,
                fieldSize: CGSize = DefaultConfiguration.fieldSize,
                animationDuration: Double = DefaultConfiguration.animationDuration,
                cursorColor: Color = DefaultConfiguration.cursorColor,
                shapeType: ShapeType = DefaultConfiguration.shapeType,
                onCompletion: ((String) -> Void)? = nil) {
        
        self.otpVerificationView = OTPVerificationView(
            digitCount: digitCount,
            spacing: spacing,
            borderColor: borderColor,
            borderWidth: borderWidth,
            textColor: textColor,
            font: font,
            backgroundColor: backgroundColor,
            cornerRadius: cornerRadius,
            fieldSize: fieldSize,
            animationDuration: animationDuration,
            cursorColor: cursorColor,
            shapeType: shapeType,
            onCompletion: onCompletion
        )
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let hostingController = UIHostingController(rootView: otpVerificationView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.frame = view.bounds
        hostingController.didMove(toParent: self)
    }
}
