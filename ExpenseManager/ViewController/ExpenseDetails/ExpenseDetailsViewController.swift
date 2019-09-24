//
// ExpenseDetailsViewController.swift
// ExpenseManager
//

import UIKit
import Photos

class ExpenseDetailsViewController: UIViewController {
    
    @IBOutlet weak var expensesTableView: UITableView!
    
    let presenter = ExpenseDetailsPresenter(provider: ExpenseDetailsProvider())
    var selectedExpense: Expenses?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
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
    
}
