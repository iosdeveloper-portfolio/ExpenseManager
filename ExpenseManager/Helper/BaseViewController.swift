//
// BaseViewController.swift
// ExpenseManager
//

import UIKit

class BaseViewController: UIViewController {
    
    private var iPhoneHeightIsBig: Bool = {
        return UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.bounds.size.height > 736
    }()
    
    private var navigationBarHeight: CGFloat {
        return self.navigationController?.navigationBar.frame.size.height ?? 44
    }
    
    // MARK: Keyboard Delegates
    func setupKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func removeKeyboradObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification)  {
        guard let userInfo = notification.userInfo else {
            return
        }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        self.view.frame.size.height = UIScreen.main.bounds.height - keyboardFrame.size.height - navigationBarHeight - (iPhoneHeightIsBig ? 40 : 20)
        self.view.setNeedsDisplay()
    }
    
    @objc func keyboardWillHide(_ notification: Notification)  {
        
        var tabBarHeight:CGFloat = 0.0
        if let tabBarController = self.tabBarController {
            tabBarHeight = tabBarController.tabBar.bounds.height
        }
        
        self.view.frame.size.height = UIScreen.main.bounds.height - navigationBarHeight - tabBarHeight - (iPhoneHeightIsBig ? 40 : 20)
        self.view.setNeedsDisplay()
    }
}
