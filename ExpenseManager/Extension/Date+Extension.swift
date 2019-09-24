//
// Date+Extension.swift
// ExpenseManager
//

import UIKit

public enum DateFormat: String {
    case expensesList = "dd MMM yyyy hh:mm a"
    case genericServer = "yyyy-MM-dd'T'HH:mm:ss.SZ"
}

extension Date {
    
    // Converts Date to String, with format
    public func toString(format: DateFormat, identifier: String? = Locale.current.identifier, timeZone: TimeZone? = TimeZone(abbreviation: "UTC")) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter.string(from: self)
    }
}
