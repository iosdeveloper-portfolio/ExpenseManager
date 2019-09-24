//
//  AlertController.swift
//  Waymaker
//


import UIKit

class AlertController {
    
    private var alertController: UIAlertController
    
    public init(alertTitle title: String, message: String? = nil) {
        self.alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    @discardableResult
    public func addAction(title: String, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)?) -> Self {
        alertController.addAction(UIAlertAction(title: title, style: style, handler: handler))
        return self
    }
    
    @discardableResult
    public func build() -> UIAlertController {
        return alertController
    }
    
}

extension UIAlertController {
    public func show(inView: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        inView.present(self, animated: animated, completion: completion)
    }
}
