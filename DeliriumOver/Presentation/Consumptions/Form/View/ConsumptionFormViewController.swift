//
//  ConsumptionFormViewController.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 08. 28..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import UIKit

class ConsumptionFormViewController : UIViewController, ConsumptionFormView, UITextFieldDelegate {
    private static let dateFormatter = DateFormatter().apply { $0.dateFormat = "HH:mm" }
    
    var presenter: ConsumptionFormPresenter?
    
    @IBOutlet weak var drink: UITextField!
    @IBOutlet weak var drinkError: UILabel!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var alcohol: UITextField!
    @IBOutlet weak var time: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    private let timePicker: DatePickerSheet = DatePickerSheet().apply { (datePicker: DatePickerSheet) in
        datePicker.datePicker.datePickerMode = UIDatePickerMode.time
    }
    private let quantityPicker: QuantityPickerSheet<DrinkUnit> = QuantityPickerSheet<DrinkUnit>().apply {
        $0.maximum = 10.0
        $0.units = DrinkUnit.allCases
    }
    private let alcoholPicker: QuantityPickerSheet<String> = QuantityPickerSheet<String>().apply {
        $0.maximum = 100.0
        $0.units = ["%"]
    }
    
    var saveIsEnabled: Bool = false {
        didSet {
            saveBtn.isEnabled = saveIsEnabled
        }
    }

    override func viewDidLoad() {
        presenter?.loadData()
        
        timePicker.onDateSelected = { self.dateSelected(date: $0) }
        timePicker.onApplyClicked = { self.view.endEditing(true) }
        quantityPicker.onQuantitySelected = { self.quantitySelected(value: $0, unit: $1) }
        quantityPicker.onApplyClicked = { self.view.endEditing(true) }
        alcoholPicker.onQuantitySelected = { (value, _) -> () in self.alcoholSelected(value: value) }
        alcoholPicker.onApplyClicked = { self.view.endEditing(true) }
        time.inputView = timePicker
        time.delegate = self
        quantity.inputView = quantityPicker
        quantity.delegate = self
        alcohol.inputView = alcoholPicker
        alcohol.delegate = self
    }
    
    func updateDrink(_ drink: String) {
        self.drink.text = drink
    }
    
    func updateTime(_ time: Date) {
        timePicker.datePicker.setDate(time, animated: true)
    }

    func showDrinkError(_ error: String) {
        drinkError.text = NSLocalizedString(error, comment: "")
        drinkError.isHidden = false
    }
    
    func hideDrinkError() {
        drinkError.isHidden = true
    }
    
    @IBAction func drinkChanged(_ sender: UITextField) {
        presenter?.onDrinkChanged(sender.text ?? "")
    }

    func dateSelected(date: Date) {
        time.text = ConsumptionFormViewController.dateFormatter.string(from: date)
        presenter?.onTimeChanged(date)
    }
    
    func quantitySelected(value: Double, unit: DrinkUnit) {
        presenter?.onQuantityChanged(value)
        presenter?.onDrinkUnitChanged(unit)
        self.quantity.text = String(format: "%.1f %@", value, unit.label())
    }
    
    func alcoholSelected(value: Double) {
        alcohol.text = String(format: "%.1f %%", value)
        presenter?.onAlcoholChanged(value)
    }
    
    func drinkUnitSeleced(value: DrinkUnit) {
        presenter?.onDrinkUnitChanged(value)
    }
    
    @IBAction func saveClicked() {
        presenter?.onSaveClicked()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
