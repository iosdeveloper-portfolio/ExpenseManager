//
// ExpenseDetailsPresenter.swift
// ExpenseManager
//

import UIKit

class ExpenseDetailsPresenter {
    
    var provider: ExpenseDetailsProvider?
    weak private var expenseDetailsView: ExpenseDetailsView?
    
    private(set) var sectionTypes: [SectionTypes] = []
    
    // MARK: - Initialization & Configuration
    init(provider: ExpenseDetailsProvider) {
        self.provider = provider
    }
    
    func attachView(view: ExpenseDetailsView?) {
        guard let view = view else { return }
        self.expenseDetailsView = view
    }
    
    enum SectionTypes {
        case header
        case list(title: String, value: String?)
        case comment(text: String?)
        case receipts(receipts: [Receipt])
    }
    
    func configureExpense(_ expense: Expenses) {
        sectionTypes.removeAll()
        sectionTypes.append(.header)
        sectionTypes.append(.list(title: LocalizedString.Common.Price, value: expense.amount?.formated()))
        sectionTypes.append(.list(title: LocalizedString.Common.Merchant, value: expense.merchant))
        sectionTypes.append(.list(title: LocalizedString.Common.Date, value: expense.date?.toDate(form: .genericServer, to: .expensesList)))
        sectionTypes.append(.comment(text: expense.comment))
        sectionTypes.append(.receipts(receipts: expense.receipts ?? []))
    }
}

extension ExpenseDetailsPresenter {
    
    func updateComment(withId id: String, comment: String) {
        RappleIndicator.start(message: LocalizedString.Common.Loading)
        provider?.updateComment(withId: id, comment: comment, completion: { (isSuccess, object) in
            if let expense = object as? Expenses {
                self.expenseDetailsView?.updateCommentRequestSuccess(withExpense: expense)
            }
            else {
                self.expenseDetailsView?.requestFailure(withError: object as? String)
            }
            RappleIndicator.stop()
        })
    }
}
