//
// Receipt.swift
// ExpenseManager
//

import Foundation

struct Receipt: Codable {
    
    let url: String?

    func fullImagePathUrl() -> URL? {
        if let url = self.url {
            return URL(string: ConfigurationURLs.base.rawValue + url)
        }
        return nil
    }
}
