//
// ReceiptUploadRouter.swift
// ExpenseManager
//

import UIKit
import Alamofire

enum ImageUploadRouter: HTTPUploadRouter {
    
    case addReceipts(withId: String, videoInfo: VideoUploadData)
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .addReceipts:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .addReceipts(let id, _):
            return "expenses/\(id)/receipts"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .addReceipts(_, let videoInfo):
            return ["receipt": videoInfo as Any]
        }
    }

    func asURL() throws -> URL {
        return url
    }
}
