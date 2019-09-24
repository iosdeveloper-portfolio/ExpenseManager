//
// HTTPUploadRouter.swift
// ExpenseManager
//

import Alamofire
import Foundation

protocol HTTPUploadRouter: URLConvertible {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
}

extension HTTPUploadRouter {
    
    var baseURL: String {
        return ConfigurationURLs.base.rawValue
    }
    
    var url: URL {
        return URL(string: baseURL + "/" + path)!
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var request: URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return urlRequest
    }
}
