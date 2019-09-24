//
// ReceiptsImageCollectionViewCell.swift
// ExpenseManager
//

import UIKit

class ReceiptsImageCollectionCell: UICollectionViewCell {
    @IBOutlet weak var receiptImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 4
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 2
    }
}
