//
// ExpensesRouter.swift
// ExpenseManager
//

import UIKit
import Alamofire

public enum ExpensesRouter: HTTPRouter {
    
    case expensesList(limit: Int, offset: Int)
    
    internal var method: HTTPMethod {
        switch self {
        case .expensesList:
            return .get
        }
    }
    
    internal var path: String {
        switch self {
        case .expensesList:
            return "expenses"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .expensesList(let limit, let offset):
            return [
                "limit": limit,
                "offset": offset
            ]
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        switch self {
        case .expensesList:
            return try URLEncoding.queryString.encode(request, with: parameters)
        }
    }
}

