//
// MultipartFormDataHelper.swift
// ExpenseManager
//

import UIKit
import Alamofire

extension MultipartFormData {
    
    func addVideoParameters(withParam parameters: [String: Any?]?) {
        
        for param in parameters ?? [:] {
            if param.value == nil {
                continue
            }
            if let videoDetails = param.value as? VideoUploadData {
                append(videoDetails.data, withName: param.key, fileName: videoDetails.fileName, mimeType: videoDetails.type.rawValue)
            }
                
            else if let stringParams = param.value as? String, let stringData = stringParams.data(using: .utf8) {
                append(stringData, withName: param.key)
            } else {
                fatalError("\(type(of: param.value)) type not posible to convert in data")
            }
        }
    }
}

public struct VideoUploadData {
    var fileName: String
    var type: ContentMIMEType
    var data: Data
}

public enum ContentMIMEType: String {
    /// Bitmap
    case bmp = "image/bmp"
    /// Graphics Interchange Format photo
    case gif = "image/gif"
    /// JPEG photo
    case jpeg = "image/jpeg"
    /// Portable network graphics
    case png = "image/png"
}
