//
// ExpensesListPresenter.swift
// ExpenseManager
//

import UIKit

class ExpensesListPresenter {
    
    var provider: ExpensesListProvider?
    weak private var expensesListView: ExpensesListView?
    
    var expenses: [Expenses] = []
    var filterExpenses: [Expenses] = []
    private var currentPage: Int = 0
    var totalPage: Int = 0
    var totalRecords: Int = 0
    var objectLimit: Int
    
    private var isProcessing: Bool = false
    
    // MARK: - Initialization & Configuration
    
    init(provider: ExpensesListProvider, objectLimit limit: Int) {
        self.provider = provider
        self.objectLimit = limit
    }
    
    func attachView(view: ExpensesListView?) {
        guard let view = view else { return }
        self.expensesListView = view
    }
    
    @discardableResult
    func getExpensesList(isPullToRefresh: Bool = false) -> Bool {
        guard !isProcessing else {
            return false
        }
        self.isProcessing = true
        
        if isPullToRefresh {
            self.expenses.removeAll()
            self.currentPage = 0
            self.totalRecords = 0
        }
        
        if !self.expenses.isEmpty && self.expenses.count >= self.totalRecords {
            return false
        }
        
        if self.currentPage == 0 && !isPullToRefresh {
            RappleIndicator.start(message: LocalizedString.Common.Loading)
        }
        
        provider?.getExpensesList(withObjectLimit: self.objectLimit, page: self.currentPage, completion: { (isSuccess, response) in
            if isSuccess, let expensesHelper = response as? ExpensesResponse, let expenses = expensesHelper.expenses {
                self.currentPage += 1
                self.totalRecords = expensesHelper.total ?? 0
                self.isProcessing = false
                let sortedExpenses = expenses.sorted { ($0.index ?? 0) < ($1.index ?? 0) }
                self.expenses.append(contentsOf: sortedExpenses)
                self.filterExpenses = self.expenses
                self.expensesListView?.requestSuccess(withExpenses: expenses)
            }
            else {
                self.expensesListView?.requestFailure(withError: response as? String)
            }
            
            RappleIndicator.stop()
        })
        return true
    }
}
