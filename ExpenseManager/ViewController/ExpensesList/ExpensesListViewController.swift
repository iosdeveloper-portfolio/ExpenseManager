//
// ExpensesListViewController.swift
// ExpenseManager
//

import UIKit

class ExpensesListViewController: UIViewController {
    
    @IBOutlet weak var expensesTableView: UITableView!
    @IBOutlet weak var expensesSearchBar: UISearchBar!
    
    let presenter = ExpensesListPresenter(provider: ExpensesListProvider(), objectLimit: 30)

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func initialSetup() {
        presenter.attachView(view: self)
        presenter.getExpensesList()
        expensesTableView.separatorStyle = .none
        self.title = LocalizedString.Titles.Expenses
        self.navigationController?.navigationBar.shadowImage = UIImage()
        expensesSearchBar.placeholder = LocalizedString.Placeholder.Search
        expensesSearchBar.delegate = self
        expensesSearchBar.barTintColor = UIColor.appColor
        expensesSearchBar.tintColor = UIColor.black
        expensesSearchBar.showsBookmarkButton = true
        expensesSearchBar.setImage(UIImage(named: "ic_filter"), for: .bookmark, state: .normal)
    }
    
    func filterIfNeeded() {
        if let searchText = expensesSearchBar.text, !searchText.isEmpty {
            presenter.filterExpenses = presenter.expenses.filter({ (expense) -> Bool in
                if expense.amount?.currency?.lowercased().range(of: searchText.lowercased()) != nil {
                    return true
                }
                if expense.user?.fullName().lowercased().range(of: searchText.lowercased()) != nil {
                    return true
                }
                if expense.merchant?.lowercased().range(of: searchText.lowercased()) != nil {
                    return true
                }
                return false
            })
        } else {
            presenter.filterExpenses = presenter.expenses
        }
        
        self.expensesTableView.reloadData()
    }
}

//MARK: - UITableView
extension ExpensesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.filterExpenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClassName: ExpenseTableViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        let expense = presenter.filterExpenses[indexPath.row]
        cell.expense = expense
        cell.layoutSubviews()
        cell.layoutIfNeeded()
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y/(scrollView.contentSize.height - scrollView.frame.size.height)
        let relativeHeight = 1 - (expensesTableView.rowHeight / (scrollView.contentSize.height - scrollView.frame.size.height))
        if y >= relativeHeight{
            presenter.getExpensesList()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ExpensesListViewController: ExpensesListView {
    func requestFailure(withError error: String?) {
        if error?.isValid ?? false {
            let alert = AlertController(alertTitle: LocalizedString.Titles.AlertGeneric, message: error)
            alert.addAction(title: LocalizedString.Button.Ok, style: .default, handler: nil)
            alert.build().show(inView: self)
        }
    }
    
    func requestSuccess(withExpenses expenses: [Expenses]) {
        self.filterIfNeeded()
    }
}

extension ExpensesListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterIfNeeded()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}
