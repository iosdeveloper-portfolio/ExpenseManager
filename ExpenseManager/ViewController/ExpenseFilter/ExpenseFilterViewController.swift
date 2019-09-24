//
// ExpenseFilterViewController.swift
// ExpenseManager
//

import UIKit
import RangeSeekSlider

enum ExpenseFilterTypes {
    case price(min: CGFloat, max: CGFloat)
}

protocol ExpenseFilterViewDelegate: class {
    var filterTypes: [ExpenseFilterTypes] { get set }
}

class ExpenseFilterViewController: UIViewController {

    @IBOutlet weak var priceRangeSlider: RangeSeekSlider!
    @IBOutlet weak var priceRangeLabel: UILabel!
    weak var delegate: ExpenseFilterViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func initialSetup() {
        self.title = LocalizedString.Titles.Filter
        
        priceRangeLabel.text = LocalizedString.Common.PriceRange
        
        priceRangeSlider.numberFormatter.locale = Locale.current
        priceRangeSlider.numberFormatter.maximumFractionDigits = 0
        priceRangeSlider.tintColor = UIColor.appColor.withAlphaComponent(0.3)
        priceRangeSlider.handleColor = UIColor.appColor
        priceRangeSlider.colorBetweenHandles = UIColor.appColor
        priceRangeSlider.minLabelColor = UIColor.appColor
        priceRangeSlider.maxLabelColor = UIColor.appColor
        priceRangeSlider.enableStep = true
        priceRangeSlider.step = priceRangeSlider.maxValue / 100
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: LocalizedString.Button.Apply, style: .plain, target: self, action: #selector(applyButtonAction(_:)))
        self.bindFilterDetails()
    }
    
    func bindFilterDetails() {
        for types in self.delegate?.filterTypes ?? [] {
            switch types {
            case .price(let min, let max):
                priceRangeSlider.selectedMinValue = min
                priceRangeSlider.selectedMaxValue = max
            }
        }
    }
    
    @objc func applyButtonAction(_ sender: UIBarButtonItem) {
        self.delegate?.filterTypes.removeAll {
            switch $0 {
            case .price: return true
            }
        }
        self.delegate?.filterTypes.append(.price(min: priceRangeSlider.selectedMinValue, max: priceRangeSlider.selectedMaxValue))
        self.navigationController?.popViewController(animated: true)
    }
}
