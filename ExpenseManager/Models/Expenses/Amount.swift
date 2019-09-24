//
//  Amount.swift
//  ExpenseManager
//

import Foundation

struct Amount: Codable {
    
	let value: String?
	let currency: String?
    
    func formated() -> String {
        return (self.currencySymbol ?? "") + " " + (self.value ?? "")
    }
    
    var currencySymbol: String? {
        guard let code = currency else { return currency ?? Locale.current.currencySymbol }
        let result = Locale.availableIdentifiers.map { Locale(identifier: $0) }.first { $0.currencyCode == code }
        return result?.currencySymbol ?? currency ?? Locale.current.currencySymbol
    }
}
