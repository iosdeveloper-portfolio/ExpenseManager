//
// ExpensesListProvider.swift
// ExpenseManager
//

import UIKit

typealias CompletionBlock = (_ success: Bool, _ response: Any?) -> Void

class ExpensesListProvider {

    func getExpensesList(withObjectLimit limit: Int, page offset: Int, completion: @escaping CompletionBlock) {
        
        let router = ExpensesRouter.expensesList(limit: limit, offset: offset)
        NetworkManager.shared.makeRequest(router) { (result: Result<ExpensesResponse, NetworkError>) in
            
            switch result {
            case .success(let expenses):
                completion(true, expenses)
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
}
