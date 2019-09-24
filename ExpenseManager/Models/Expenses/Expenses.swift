//
//  Expenses.swift
//  ExpenseManager
//

import UIKit

struct Expenses: Codable {
    
	let id: String?
	let amount: Amount?
	let date: String?
	let merchant: String?
	let receipts: [Receipt]?
	let comment: String?
	let category: String?
	let user: User?
	let index: Int?
    
    func randomColor() -> UIColor {
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        return UIColor(red:red, green: green, blue: blue, alpha: 0.6)
    }
}
