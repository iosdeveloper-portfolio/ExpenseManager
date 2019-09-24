//
// ExpensesRouter.swift
// ExpenseManager
//

import UIKit
import Alamofire

public enum ExpensesRouter: HTTPRouter {
    
    case expensesList(limit: Int, offset: Int)
    case addExpenseComment(id: String, comment: String)
    
    internal var method: HTTPMethod {
        switch self {
        case .expensesList:
            return .get
        case .addExpenseComment:
            return .post
        }
    }
    
    internal var path: String {
        switch self {
        case .expensesList:
            return "expenses"
        case .addExpenseComment(let id, _):
            return "expenses/\(id)"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .expensesList(let limit, let offset):
            return [
                "limit": limit,
                "offset": offset
            ]
        case .addExpenseComment(_, let comment):
            return ["comment": comment]
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        switch self {
        case .expensesList:
            return try URLEncoding.queryString.encode(request, with: parameters)
        case .addExpenseComment:
            return try URLEncoding.default.encode(request, with: parameters)
        }
    }
}

