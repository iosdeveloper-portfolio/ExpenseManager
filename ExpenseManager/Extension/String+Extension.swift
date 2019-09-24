//
// String+Extension.swift
// ExpenseManager
//

import UIKit

extension String {

    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: "\(self)", comment: "")
    }
}
