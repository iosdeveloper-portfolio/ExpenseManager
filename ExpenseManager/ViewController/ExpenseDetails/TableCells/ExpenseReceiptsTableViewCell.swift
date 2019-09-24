//
// ExpenseReceiptsTableViewCell.swift
// ExpenseManager
//

import UIKit
import SDWebImage
import DTPhotoViewerController

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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        if let cell = collectionView.cellForItem(at: indexPath) as? ReceiptsImageCollectionCell {
            selectedImageIndex = indexPath.row
            let photoViewer = DTPhotoViewerController(referencedView: cell.receiptImageView, image: cell.receiptImageView.image)
            photoViewer.delegate = self
            photoViewer.dataSource = self
            appDelegate.window?.rootViewController?.present(photoViewer, animated: true, completion: nil)
        }
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

extension ExpenseReceiptsTableViewCell: DTPhotoViewerControllerDelegate {
    
    func photoViewerController(_ photoViewerController: DTPhotoViewerController, referencedViewForPhotoAt index: Int) -> UIView? {
        let indexPath = IndexPath(item: index, section: 0)
        if let cell = self.receiptsCollectionView.cellForItem(at: indexPath) as? ReceiptsImageCollectionCell {
            return cell.receiptImageView
        }
        
        return nil
    }
    
    func numberOfItems(in photoViewerController: DTPhotoViewerController) -> Int {
        return receipts.count
    }
    
    func photoViewerController(_ photoViewerController: DTPhotoViewerController, configureCell cell: DTPhotoCollectionViewCell, forPhotoAt index: Int) {
        // You need to implement this method usually when using custom DTPhotoCollectionViewCell and configure each photo differently.
    }
    
    func photoViewerController(_ photoViewerController: DTPhotoViewerController, configurePhotoAt index: Int, withImageView imageView: UIImageView) {
        let url = receipts[index].fullImagePathUrl()
        imageView.sd_setImage(with: url, placeholderImage: nil, options: [.continueInBackground, .refreshCached], completed: nil)
    }
}

extension ExpenseReceiptsTableViewCell: DTPhotoViewerControllerDataSource {
    func photoViewerControllerDidEndPresentingAnimation(_ photoViewerController: DTPhotoViewerController) {
        photoViewerController.scrollToPhoto(at: selectedImageIndex, animated: false)
    }
    
    func photoViewerController(_ photoViewerController: DTPhotoViewerController, didScrollToPhotoAt index: Int) {
        selectedImageIndex = index
        if let collectionView = receiptsCollectionView {
            let indexPath = IndexPath(item: selectedImageIndex, section: 0)
            
            // If cell for selected index path is not visible
            if !collectionView.indexPathsForVisibleItems.contains(indexPath) {
                // Scroll to make cell visible
                collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.bottom, animated: false)
            }
        }
    }
}
