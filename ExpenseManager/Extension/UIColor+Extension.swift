//
// UIColor+Extension.swift
// ExpenseManager
//

import UIKit

extension UIColor {
    
    static let appColor = UIColor(rgb: 0xFF3366)
    static let primaryText = UIColor(rgb: 0x000000)
    static let secondryText = UIColor(rgb: 0x444444)
    static let lightText = UIColor.lightGray
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
