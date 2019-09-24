//
// ExpenseReceiptsTableViewCell.swift
// ExpenseManager
//

import UIKit
import SDWebImage

protocol ExpenseReceiptsDelegate: class {
    func addReceiptButtonAction(_ addReceiptButton: UIButton)
}

class ExpenseReceiptsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addNewReceiptsButton: UIButton!
    @IBOutlet weak var receiptsCollectionView: UICollectionView!
    @IBOutlet weak var receiptsCollectionViewHeightConstaint: NSLayoutConstraint!
    
    weak var delegate: ExpenseReceiptsDelegate?
    fileprivate var selectedImageIndex: Int = 0
    
    var receipts: [Receipt] = [] {
        didSet {
            receiptsCollectionViewHeightConstaint.constant = receipts.isEmpty ? 0 : 110
            self.receiptsCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addNewReceiptsButton.setTitle(LocalizedString.Common.AddReceipt, for: .normal)
        titleLabel.textColor = .primaryText
        titleLabel.text = LocalizedString.Common.Receipts
        receiptsCollectionView.delegate = self
        receiptsCollectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func addReceiptsButtonAction(_ sender: UIButton) {
        delegate?.addReceiptButtonAction(sender)
    }
}

extension ExpenseReceiptsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return receipts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClassName: ReceiptsImageCollectionCell.self, for: indexPath)
        let url = receipts[indexPath.row].fullImagePathUrl()
        cell.receiptImageView.sd_setImage(with: url, placeholderImage: nil, options: [.continueInBackground, .refreshCached], completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height - 5 - 10
        return CGSize(width: height, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

