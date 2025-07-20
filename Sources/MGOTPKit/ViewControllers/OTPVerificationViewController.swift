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
    private let otpVerificationView: AnyOTPVerificationView
    public init(configuration: OTPConfiguration) {
        let view = OTPVerificationView(
            digitCount: configuration.digitCount,
            spacing: configuration.spacing,
            borderColor: configuration.borderColor,
            borderWidth: configuration.borderWidth,
            textColor: configuration.textColor,
            font: configuration.font,
            backgroundColor: configuration.backgroundColor,
            cornerRadius: configuration.cornerRadius,
            fieldSize: configuration.fieldSize,
            animationDuration: configuration.animationDuration,
            cursorColor: configuration.cursorColor,
            shapeType: configuration.shapeType,
            onCompletion: configuration.onCompletion
        )
        self.otpVerificationView = AnyOTPVerificationView(view)
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
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostingController.didMove(toParent: self)
    }
}

