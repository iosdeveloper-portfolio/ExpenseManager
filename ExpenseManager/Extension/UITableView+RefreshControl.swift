//
// UITableView+RefreshControl.swift
// ExpenseManager
//

import UIKit

extension UITableView {
    private struct AssociatedKeys {
        static var ActionKey = "UIRefreshControlActionKey"
    }
    
    private class ActionWrapper {
        let action: RefreshControlAction
        init(action: @escaping RefreshControlAction) {
            self.action = action
        }
    }
    
    typealias RefreshControlAction = ((UIRefreshControl) -> Void)
    
    var pullToRefresh: (RefreshControlAction)? {
        set(newValue) {
            customRefreshControl.removeTarget(self, action: #selector(refreshAction(_:)), for: .valueChanged)
            var wrapper: ActionWrapper? = nil
            if let newValue = newValue {
                wrapper = ActionWrapper(action: newValue)
                customRefreshControl.addTarget(self, action: #selector(refreshAction(_:)), for: .valueChanged)
            }
            
            objc_setAssociatedObject(self, &AssociatedKeys.ActionKey, wrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let wrapper = objc_getAssociatedObject(self, &AssociatedKeys.ActionKey) as? ActionWrapper else {
                return nil
            }
            
            return wrapper.action
        }
    }
    
    private var customRefreshControl: UIRefreshControl {
        if #available(iOS 10.0, *) {
            if let refreshView = self.refreshControl {
                return refreshView
            }
            else{
                self.refreshControl = UIRefreshControl()
                return self.refreshControl!
            }
        }
        else{
            if let refreshView = backgroundView as? UIRefreshControl {
                return refreshView
            }
            else{
                backgroundView = UIRefreshControl()
                return UIRefreshControl()
            }
        }
    }
    
    func endRefreshing() {
        self.customRefreshControl.endRefreshing()
    }
    
    func beginRefreshing() {
        self.customRefreshControl.beginRefreshing()
    }
    
    @objc private func refreshAction(_ refreshControl: UIRefreshControl) {
        if let action = pullToRefresh {
            action(refreshControl)
        }
    }
}
