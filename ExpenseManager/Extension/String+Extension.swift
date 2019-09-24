//
// String+Extension.swift
// ExpenseManager
//

import UIKit

extension String {
    
    public var isValid: Bool {
        if isBlank == false && count > 0 {
            return true
        }
        return false
    }
    
    public var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmed.isEmpty
        }
    }

    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: "\(self)", comment: "")
    }
    
    // Converts String to formated date string, with inputFormat and outputFormat
    public func toDate(form inputFormat: DateFormat, to outputFormat: DateFormat) -> String? {
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = inputFormat.rawValue
        let date = formatter.date(from: self)
        
        return date?.toString(format: outputFormat)
    }
}
