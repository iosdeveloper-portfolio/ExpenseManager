//
// RappleIndicator.swift
// ExpenseManager
//

import UIKit
import RappleProgressHUD

struct RappleIndicator {
    
    static func start(withStyle style: RappleStyle = .apple, message: String) {
        DispatchQueue.main.async() {
            let attributes = RappleActivityIndicatorView.attribute(style: style)
            RappleActivityIndicatorView.startAnimatingWithLabel(message, attributes: attributes)
        }
    }
    
    static func stop() {
        DispatchQueue.main.async() {
            RappleActivityIndicatorView.stopAnimation()
        }
    }
}
