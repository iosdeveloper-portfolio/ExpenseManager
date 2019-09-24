//
// ExpenseDetailsViewController.swift
// ExpenseManager
//

import UIKit
import Photos

protocol ExpenseDetailsViewDelegate: class {
    func expenseObjectValueChange(_ expenseDetailsVC: ExpenseDetailsViewController, expense: Expenses)
}

class ExpenseDetailsViewController: BaseViewController {
    
    @IBOutlet weak var expensesTableView: UITableView!
    
    let presenter = ExpenseDetailsPresenter(provider: ExpenseDetailsProvider())
    var selectedExpense: Expenses?
    var isCommentEditing: Bool = false {
        didSet {
            self.expensesTableView.beginUpdates()
            self.expensesTableView.endUpdates()
        }
    }
    
    weak var delegate: ExpenseDetailsViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeKeyboradObserver()
    }
    
    func initialSetup() {
        guard let expense = selectedExpense else { return }
        presenter.attachView(view: self)
        presenter.configureExpense(expense)
        expensesTableView.separatorInset = .zero
        expensesTableView.bounces = false
        expensesTableView.tableFooterView = UIView()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = LocalizedString.Titles.ExpensesDetails
        
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(backButtonAction(_:)))
        self.navigationController?.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func backButtonAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - UITableView
extension ExpenseDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.sectionTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let expense = selectedExpense else {
            return  UITableViewCell()
        }
        
        switch presenter.sectionTypes[indexPath.row] {
        case .header:
            let cell = tableView.dequeueReusableCell(withClassName: ExpenseHeaderCell.self, for: indexPath)
            cell.selectionStyle = .none
            cell.expense = expense
            return cell
            
        case .list(let title, let value):
            let cell = tableView.dequeueReusableCell(withClassName: ExpenseDetailsTableViewCell.self, for: indexPath)
            cell.selectionStyle = .none
            cell.titleLabel.text = title
            cell.detailLabel.text = value
            return cell
            
        case .comment(let text):
            let cell = tableView.dequeueReusableCell(withClassName: ExpenseCommentTableViewCell.self, for: indexPath)
            cell.selectionStyle = .none
            cell.configureTextView(withComment: text)
            cell.delegate = self
            return cell
            
        case .receipts(let receipts):
            let cell = tableView.dequeueReusableCell(withClassName: ExpenseReceiptsTableViewCell.self, for: indexPath)
            cell.selectionStyle = .none
            cell.receipts = receipts
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ExpenseDetailsViewController: ExpenseDetailsView {
    func requestFailure(withError error: String?) {
        if error?.isValid ?? false {
            let alert = AlertController(alertTitle: LocalizedString.Titles.AlertGeneric, message: error)
            alert.addAction(title: LocalizedString.Button.Ok, style: .default, handler: nil)
            alert.build().show(inView: self)
        }
    }
    
    func updateCommentRequestSuccess(withExpense expense: Expenses) {
        DispatchQueue.main.async {
            self.selectedExpense = expense
            self.presenter.configureExpense(expense)
            self.delegate?.expenseObjectValueChange(self, expense: expense)
        }
    }
}

extension ExpenseDetailsViewController: ExpenseCommentEditDoneDelegate {

    func commentUpdate(newComment: String) {
        
        guard let expense = selectedExpense else { return }
        for sectionType in presenter.sectionTypes {
            switch sectionType {
            case .comment(let text):
                if newComment.isBlank {
                    let alert = AlertController(alertTitle: LocalizedString.Titles.AlertGeneric, message: LocalizedString.Errors.enterComment)
                    alert.addAction(title: LocalizedString.Button.Ok, style: .default, handler: nil)
                    alert.build().show(inView: self)
                } else if newComment != text {
                    presenter.updateComment(withId: expense.id ?? "", comment: newComment)
                }
            default: break
            }
        }
    }
    
    func updateHeightOfRow(_ cell: ExpenseCommentTableViewCell, _ textView: UITextView) {
        let size = textView.bounds.size
        let newSize = expensesTableView.sizeThatFits(CGSize(width: size.width,
                                                            height: CGFloat.greatestFiniteMagnitude))
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            expensesTableView.beginUpdates()
            expensesTableView.endUpdates()
            UIView.setAnimationsEnabled(true)
            if let thisIndexPath = expensesTableView.indexPath(for: cell) {
                expensesTableView.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
            }
        }
    }
}
