//
// ExpenseDetailsProvider.swift
// ExpenseManager
//

import UIKit

class ExpenseDetailsProvider {
    func updateComment(withId id: String, comment: String, completion: @escaping CompletionBlock) {
        
        let router = ExpensesRouter.addExpenseComment(id: id, comment: comment)
        NetworkManager.shared.makeRequest(router) { (result: Result<Expenses, NetworkError>) in
            
            switch result {
            case .success(let expenses):
                completion(true, expenses)
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
    
    func uploadReceipt(withId id: String, receiptImage: UIImage, completion: @escaping CompletionBlock) {
        
        guard let imageData = receiptImage.pngData() else {
            return
        }
        let videoInfo = VideoUploadData(fileName: "receipt.png", type: .png, data: imageData)
        let route = ImageUploadRouter.addReceipts(withId: id, videoInfo: videoInfo)
        NetworkManager.shared.makeMultipartUploadRequest(route) { (result: Result<Expenses, NetworkError>) in
            
            switch result {
            case .success(let expenses):
                completion(true, expenses)
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
}
