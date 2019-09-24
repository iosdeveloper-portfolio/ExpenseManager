//
// ExpenseTableViewCell.swift
// ExpenseManager
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userIconLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var merchantLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var receiptsCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        currencyLabel.textColor = UIColor.appColor
        
        userIconLabel.textColor = UIColor.primaryText
        userIconLabel.clipsToBounds = true
        
        userNameLabel.textColor = UIColor.primaryText
        merchantLabel.textColor = UIColor.secondryText
        dateLabel.textColor = UIColor.lightText
        receiptsCountLabel.textColor = UIColor.secondryText
        
        containerView.layer.cornerRadius = 6
        containerView.layer.shadowColor = UIColor.darkText.cgColor
        containerView.layer.shadowOffset = CGSize(width: 1, height: 1)
        containerView.layer.shadowRadius = 3
        containerView.layer.shadowOpacity = 0.3
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var expense: Expenses? {
        didSet {
            userIconLabel.backgroundColor = expense?.randomColor()
            userIconLabel.text = expense?.user?.initials()
            
            userNameLabel.text = expense?.user?.fullName()
            merchantLabel.text = expense?.merchant?.capitalized
            currencyLabel.text = expense?.amount?.formated()
            dateLabel.text = expense?.date?.toDate(form: .genericServer, to: .expensesList)
            if let receipts = expense?.receipts, !receipts.isEmpty {
                receiptsCountLabel.text = "\(receipts.count) " + (receipts.count != 1 ? LocalizedString.Common.Receipts : LocalizedString.Common.Receipt)
            } else {
                receiptsCountLabel.text = ""
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userIconLabel.layer.cornerRadius = userIconLabel.frame.height / 2
    }
}
