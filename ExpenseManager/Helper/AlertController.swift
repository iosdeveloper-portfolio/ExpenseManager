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
    
    public init(actionSheetTitle title: String, message: String? = nil) {
        self.alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    }
    
    enum PopoverSourceType {
        case sourceView(UIView)
        case sourceRect(CGRect)
        case barButtonItem(UIBarButtonItem)
    }
    
    @discardableResult
    public func setPopoverPresentationProperties(withSources sourceView: PopoverSourceType, permittedArrowDirections: UIPopoverArrowDirection? = nil) -> Self {
        
        if let poc = alertController.popoverPresentationController {
            switch sourceView {
            case .sourceView(let view):
                poc.sourceView = view
            case .sourceRect(let rect):
                poc.sourceRect = rect
            case .barButtonItem(let item):
                poc.barButtonItem = item
            }
            
            if let directions = permittedArrowDirections {
                poc.permittedArrowDirections = directions
            }
        }
        
        return self
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
        DispatchQueue.main.async {
            inView.present(self, animated: animated, completion: completion)
        }
    }
}
