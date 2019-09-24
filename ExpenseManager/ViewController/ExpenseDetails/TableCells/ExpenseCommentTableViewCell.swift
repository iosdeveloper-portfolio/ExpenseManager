//
// ExpenseCommentTableViewCell.swift
// ExpenseManager
//

import UIKit

class ExpenseCommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var editDoneButton: UIButton!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var commentTextViewHeightConstaint: NSLayoutConstraint!
    
    static let rowHeight: CGFloat = 80
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.textColor = .primaryText
        titleLabel.text = LocalizedString.Common.Comment
        
        commentTextView.isScrollEnabled = false
        commentTextView.isEditable = false
        commentTextView.delegate = self
        commentTextView.text = LocalizedString.Placeholder.WriteYourComment
        commentTextView.textColor = UIColor.lightGray
        commentTextView.font = UIFont.systemFont(ofSize: 14)
        commentTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        commentTextView.addDoneButtonOnKeyboard()
        editDoneButton.setTitle(LocalizedString.Button.Edit, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureTextView(withComment text: String?) {
        if let text = text, !text.isBlank {
            commentTextView.text = text
            commentTextView.textColor = UIColor.secondryText
        }
    }
    
    @IBAction func editDoneButtonAction(_ sender: UIButton) {
        sender.endEditing(true)
    }
}

extension ExpenseCommentTableViewCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.secondryText
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = LocalizedString.Placeholder.WriteYourComment
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            textView.text = LocalizedString.Placeholder.WriteYourComment
            textView.textColor = UIColor.lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.secondryText
            textView.text = text
        }
        else {
            return true
        }
        return false
    }
}

