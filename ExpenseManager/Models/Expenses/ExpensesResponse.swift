//
//  ExpensesResponse.swift
//  ExpenseManager
//

import Foundation

struct ExpensesResponse: Codable {
    
	let expenses: [Expenses]?
	let total: Int?
}
