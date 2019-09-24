//
// ExpensesListViewController.swift
// ExpenseManager
//

import UIKit

class ExpensesListViewController: UIViewController {
    
    @IBOutlet weak var expensesTableView: UITableView!
    @IBOutlet weak var expensesSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func initialSetup() {
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
}

//MARK: - UITableView
extension ExpensesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClassName: ExpenseTableViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        cell.layoutSubviews()
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension ExpensesListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}

