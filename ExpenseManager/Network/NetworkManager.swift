//
// NetworkManager.swift
// ExpenseManager
//

import UIKit
import Alamofire
import CodableAlamofire
import AlamofireNetworkActivityIndicator

class NetworkManager {
    
    static let shared = NetworkManager()
    
    static let networkUnavailableCode: Double = 1000
    
    init() {
        NetworkActivityIndicatorManager.shared.isEnabled = true
    }
        
    func makeRequest<T: Decodable>(_ urlRequest: URLRequestConvertible, completion: @escaping (Swift.Result<T, NetworkError>) -> ()) {
        
        Alamofire.request(urlRequest)
            .validate()
            .responseDecodableObject(completionHandler: { (response: DataResponse<T>)-> Void in
                
                switch response.result {
                case .success(let JSON):
                    completion(.success(JSON))
                    
                case .failure(let error):
                    completion(.failure(self.generateError(from: error, with: response)))
                }
            })
    }
    
    func makeRequest<T: Decodable>(_ urlRequest: URLRequestConvertible, completion: @escaping (Swift.Result<[T], NetworkError>) -> ()) {
        
        Alamofire.request(urlRequest)
            .validate()
            .responseDecodableObject(completionHandler: { (response: DataResponse<[T]>)-> Void in
                
                switch response.result {
                case .success(let JSON):
                    completion(.success(JSON))
                    
                case .failure(let error):
                    completion(.failure(self.generateError(from: error, with: response)))
                }
            })
    }
    
    fileprivate func error(fromResponseObject responseObject: DataResponse<Any>) -> NetworkError? {
        if let statusCode = responseObject.response?.statusCode {
            switch statusCode {
            case 200...300: return nil
            default:
                if let result = responseObject.result.value as? [String: Any],
                    let error = result["error"] as? [String: Any],
                    let errorMessage = error["message"] as? String {
                    if let code = result["status"] as? Double {
                        return NetworkError.error(code: code, message: errorMessage)
                    } else {
                        return NetworkError.errorString(errorMessage)
                    }
                }
            }
        }
        return NetworkError.generic
    }
    
    fileprivate func generateError<T>(from error: Error, with responseObject: DataResponse<T>) -> NetworkError {
        if let statusCode = responseObject.response?.statusCode {
            if let data = responseObject.data, let jsonString = String(data: data, encoding: .utf8) {
                return NetworkError.error(code: Double(statusCode), message: jsonString)
            }
        } else {
            let code = (error as NSError).code
            switch code {
            case NSURLErrorNotConnectedToInternet, NSURLErrorCannotConnectToHost, NSURLErrorCannotFindHost:
                return NetworkError.error(code: NetworkManager.networkUnavailableCode, message: LocalizedString.Errors.networkUnreachableError)
            default:
                return NetworkError.errorString(error.localizedDescription)
            }
        }
        return NetworkError.generic
    }
}
