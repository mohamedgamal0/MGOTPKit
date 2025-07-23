//
//  OTPVerificationViewController.swift
//  MGOTPKit
//
//  Created by Mohamed Gamal on 10/11/2024.
//

import SwiftUI
import UIKit

// UIKit wrapper for OTPVerificationView
public class OTPVerificationViewController: UIViewController {
    private var otpVerificationView: OTPVerificationView
    private var hostingController: UIHostingController<OTPVerificationView>?
    private let configuration: OTPConfiguration
    
    public init(configuration: OTPConfiguration) {
        self.configuration = configuration
         
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
            errorBorderColor: configuration.errorBorderColor,
            onCompletion: configuration.onCompletion
        )
        
        self.otpVerificationView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        hostingController = UIHostingController(rootView: otpVerificationView)
        guard let hostingController = hostingController else { return }
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.frame = view.bounds
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostingController.didMove(toParent: self)
    }
    
    public func setErrorState(_ isError: Bool) {
        otpVerificationView.setErrorState(isError)
        hostingController?.rootView = otpVerificationView
    }
    
    public func clearFields() {
        otpVerificationView.clearFields()
        hostingController?.rootView = otpVerificationView
    }
    
    public func getCurrentOTP() -> String {
        return otpVerificationView.getCurrentOTP()
    }
    
    public func resetErrorState() {
        otpVerificationView.setErrorState(false)
        hostingController?.rootView = otpVerificationView
    }
}
