//
//  HTTPRouter.swift
//  ExpenseManager
//

import Foundation
import Alamofire

enum ConfigurationURLs: String {
    case base = "http://192.168.0.9:3000"
}

protocol HTTPRouter: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    var request: URLRequest { get }
}

extension HTTPRouter {
    
    var baseURL: String {
        return ConfigurationURLs.base.rawValue
    }
    
    var url: URL {
        return URL(string: baseURL + "/" + path)!
    }
    
    private var parameters: [String: Any]? {
        return nil
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var request: URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return urlRequest
    }
}
