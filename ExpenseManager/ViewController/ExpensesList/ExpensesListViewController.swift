//
// ExpensesListViewController.swift
// ExpenseManager
//

import UIKit

class ExpensesListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func initialSetup() {
        self.title = LocalizedString.Titles.Expenses
    }
}



