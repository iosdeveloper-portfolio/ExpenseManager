//
// Constant.swift
// ExpenseManager
//

import UIKit

struct LocalizedString {
    
    struct Errors {
        static let genericError = "Error_genric".localized
        static let networkUnreachableError  = "Error_no_internet".localized
    }
    
    struct Titles {
        static let Expenses = "Expenses".localized
        static let AlertGeneric = "Alert".localized
        static let Filter = "Filter".localized
    }
    
    struct Placeholder {
        static let Search = "Search".localized
    }
    
    struct Common {
        static let Loading = "Loading".localized
        static let Receipts = "Receipts".localized
        static let Receipt = "Receipt".localized
        static let PriceRange = "Price_range".localized
    }
    
    struct Button {
        static let Ok = "Ok".localized
        static let Apply = "Apply".localized
    }
}
