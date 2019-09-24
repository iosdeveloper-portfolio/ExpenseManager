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
        static let ExpensesDetails = "Expenses_details".localized
    }
    
    struct Placeholder {
        static let Search = "Search".localized
        static let WriteYourComment = "write_comment".localized
    }
    
    struct Common {
        static let Loading = "Loading".localized
        static let Receipts = "Receipts".localized
        static let Receipt = "Receipt".localized
        static let PriceRange = "Price_range".localized
        static let Price = "Price".localized
        static let Merchant = "Merchant".localized
        static let Date = "Date".localized
        static let AddReceipt = "Add_receipt".localized
        static let Comment = "Comment".localized
    }
    
    struct Button {
        static let Ok = "Ok".localized
        static let Apply = "Apply".localized
        static let Edit = "Edit".localized
        static let Save = "Save".localized
        static let Done = "Done".localized
    }
}
