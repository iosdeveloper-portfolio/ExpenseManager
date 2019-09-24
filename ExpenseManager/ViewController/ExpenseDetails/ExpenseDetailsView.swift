//
// ExpenseDetailsView.swift
// ExpenseManager
//

import UIKit

protocol ExpenseDetailsView: class {
    func requestFailure(withError error:  String?)
    func updateCommentRequestSuccess(withExpense expense: Expenses)
    func receiptUploadRequestSuccess(withExpense expense: Expenses)
}
