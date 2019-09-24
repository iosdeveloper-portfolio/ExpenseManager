//
// Storyboard.swift
// ExpenseManager
//

import UIKit

enum Storyboard: String {
    case Main
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func instantiateViewController<T : UIViewController>(withClass viewController: T.Type) -> T {
        let storyboardID = viewController.storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
}

extension UIViewController {
    class var storyboardID : String {
        return String(describing: self)
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(withClassName className: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: className), for: indexPath) as! T
    }
}

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(withClassName className: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: String(describing: className), for: indexPath) as! T
    }
}
